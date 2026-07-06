#ifndef BOOST_STD_CONFIGURATION_H
#define BOOST_STD_CONFIGURATION_H

#define STD_SHARED_MUTEX_FOUND 1
#define Boost_SHARED_MUTEX_FOUND 0
#define STD_FILESYSTEM_FOUND 1
#define Boost_FILESYSTEM_FOUND 0
#define STD_EXPERIMENTAL_FILESYSTEM_FOUND 1

#if STD_SHARED_MUTEX_FOUND
#include <shared_mutex>
namespace log4cxx {
    typedef std::shared_mutex shared_mutex;
    template <typename T>
    using shared_lock = std::shared_lock<T>;
}
#elif Boost_SHARED_MUTEX_FOUND
#include <boost/thread/shared_mutex.hpp>
namespace log4cxx {
    typedef boost::shared_mutex shared_mutex;
    template <typename T>
    using shared_lock = boost::shared_lock<T>;
}
#endif

#if STD_FILESYSTEM_FOUND
#include <filesystem>
namespace log4cxx {
namespace filesystem {
    typedef std::filesystem::path path;
}
}
#elif STD_EXPERIMENTAL_FILESYSTEM_FOUND
#include <experimental/filesystem>
namespace log4cxx {
namespace filesystem {
    typedef std::experimental::filesystem::path path;
}
}
#elif Boost_FILESYSTEM_FOUND
#include <boost/filesystem.hpp>
namespace log4cxx {
namespace filesystem {
    typedef boost::filesystem::path path;
}
}
#endif

#endif /* BOOST_STD_CONFIGURATION_H */
