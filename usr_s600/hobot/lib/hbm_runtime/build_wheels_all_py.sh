#!/usr/bin/env bash
set -e
CMD="${1:-run}"
# Build wheels in py38~py313, then repair ALL wheels in py312.
# - Each conda env installs: build + auditwheel (per your request)
# - Repaired wheels are put into ONE folder: wheel_out/

BUILD_ENVS=(py38 py39 py310 py311 py312 py313)
REPAIR_ENV=py312
OUT_DIR="${OUT_DIR:-wheel_out}"

# ---- added: auto install miniconda + auto create envs ----
MINICONDA_DIR="${MINICONDA_DIR:-$HOME/miniconda3}"
MINICONDA_URL="${MINICONDA_URL:-https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh}"

ensure_conda() {
  if command -v conda >/dev/null 2>&1; then
    # shellcheck disable=SC1090
    source "$(conda info --base)/etc/profile.d/conda.sh"
    return
  fi

  if [[ -f "${MINICONDA_DIR}/etc/profile.d/conda.sh" ]]; then
    # shellcheck disable=SC1090
    source "${MINICONDA_DIR}/etc/profile.d/conda.sh"
    return
  fi

  echo "[setup] conda not found, install Miniconda -> ${MINICONDA_DIR}"
  tmp="/tmp/miniconda.sh"

  wget -qO "${tmp}" "${MINICONDA_URL}"

  bash "${tmp}" -b -p "${MINICONDA_DIR}"
  rm -f "${tmp}"
  # shellcheck disable=SC1090
  source "${MINICONDA_DIR}/etc/profile.d/conda.sh"

  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main >/dev/null 2>&1 || true
  conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r    >/dev/null 2>&1 || true

}

env_exists() {
  conda env list | awk '{print $1}' | grep -qx "$1"
}

ensure_envs() {
  conda config --add channels conda-forge >/dev/null 2>&1 || true
  conda config --set channel_priority strict >/dev/null 2>&1 || true

  for env in "${BUILD_ENVS[@]}"; do
    if env_exists "${env}"; then
      continue
    fi

    # map env name -> python version
    pyver=""
    case "${env}" in
      py38)  pyver="3.8" ;;
      py39)  pyver="3.9" ;;
      py310) pyver="3.10" ;;
      py311) pyver="3.11" ;;
      py312) pyver="3.12" ;;
      py313) pyver="3.13" ;;
      *) echo "[setup] unknown env: ${env}"; exit 1 ;;
    esac

    echo "[setup] create env ${env} (python=${pyver})"
    conda create -y -n "${env}" "python=${pyver}" >/dev/null
  done
}
# ---- end added ----

ensure_conda
ensure_envs

ROOT="$(cd "$(dirname "$0")" && pwd)"
RAW_DIR="${ROOT}/_raw_wheels"
DIST_DIR="${ROOT}/dist"

EXCLUDES=(
  libbpu.so.2
  libhbmem.so.1
  libalog.so.1
  libhbrt4.so
  libdnn.so
  libhbucp.so
  libhbtl.so
  libhb_arm_rpc.so
  libperfetto_sdk.so
  libcjson.so.1
  libjsoncpp.so.1
)

do_clean() {
  echo "[clean]"
  rm -rf build _skbuild *.egg-info __pycache__ "${RAW_DIR}" "${DIST_DIR}" "${OUT_DIR}"
}

if [[ "${CMD:-run}" == "clean" ]]; then
  do_clean
  echo "DONE (clean)"
  exit 0
fi

do_clean
mkdir -p "${RAW_DIR}" "${OUT_DIR}"

echo "[build] python 3.8 ~ 3.13"
for env in "${BUILD_ENVS[@]}"; do
  echo "  -> ${env}"
  conda activate "${env}"

  # per-env deps (build + auditwheel)
  python -m pip install -U pip build auditwheel scikit-build-core pybind11 >/dev/null

  rm -rf build _skbuild *.egg-info __pycache__ "${DIST_DIR}"
  python -m build --wheel

  cp "${DIST_DIR}"/*.whl "${RAW_DIR}/"
  rm -rf "${DIST_DIR}"

  conda deactivate
done

echo "[repair] in ${REPAIR_ENV}"
conda activate "${REPAIR_ENV}"
python -m pip install -U pip auditwheel >/dev/null

EXCL_ARGS=()
for s in "${EXCLUDES[@]}"; do
  EXCL_ARGS+=(--exclude "$s")
done

auditwheel repair "${RAW_DIR}"/*.whl -w "${OUT_DIR}" "${EXCL_ARGS[@]}"

conda deactivate
echo "DONE -> ${OUT_DIR}"
