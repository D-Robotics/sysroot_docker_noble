#  Copyright (c) 2023 Canonical
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
#  USA

import os
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

from aptsources.sourceslist import Deb822SourceEntry
from softwareproperties.gtk.utils import (
    setup_ui,
)


class _CustomSourceEntryField(Gtk.Grid):
    def __init__(self, window, input_changed_callback, key=None, value=None):
        super(Gtk.Grid, self).__init__()

        self.window = window
        self.entry_key = Gtk.Entry(name='field_key', placeholder_text='Key')
        self.entry_val = Gtk.Entry(name='field_value', placeholder_text='Value')
        self.button_delete = Gtk.Button.new_from_stock('gtk-delete')

        if key is not None:
            self.entry_key.set_text(key)

        if value is not None:
            self.entry_val.set_text(value)

        self.set_column_spacing(12)
        self.attach(self.entry_key, 0, 0, 1, 1)
        self.attach(self.entry_val, 1, 0, 1, 1)
        self.attach(self.button_delete, 2, 0, 1, 1)

        self.connect('destroy', input_changed_callback)
        self.entry_key.connect('changed', input_changed_callback)
        self.entry_val.connect('changed', input_changed_callback)
        self.button_delete.connect('clicked',
                                  self._button_del_field_clicked_callback)

    def _button_del_field_clicked_callback(self, *data):
        parent = self.get_parent()
        parent.get_parent().remove(parent)

        # Shrink the height back to size after deleting items.
        width = self.window.get_default_size()[0]
        self.window.resize(width, 1)

    def get_key(self):
        return self.entry_key.get_text()

    def get_val(self):
        return self.entry_val.get_text()


class DialogEditDeb822:
    def __init__(self, parent, sourceslist, source_entry, datadir):
        self.sourceslist = sourceslist
        self.source_entry = source_entry
        self.new_source_entry = None

        setup_ui(
            self,
            os.path.join(datadir, 'gtkbuilder', 'dialog-edit-deb822-source.ui'),
            domain='software-properties'
        )
        self.main = self.dialog_edit_deb822
        self.main.set_transient_for(parent)

        self._populate_with_existing_source_entry()
        self._connect_signal_callbacks()

    def _populate_with_existing_source_entry(self):
        self.entry_types.set_text(" ".join(self.source_entry.types))
        self.entry_uris.set_text(" ".join(self.source_entry.uris))
        self.entry_suites.set_text(" ".join(self.source_entry.suites))
        self.entry_comps.set_text(" ".join(self.source_entry.comps))
        self.entry_comment.set_text(self.source_entry.comment.rstrip())

        for key, value in self.source_entry.section.tags.items():
            if key not in ['Types', 'URIs', 'Suites', 'Components']:
                self._append_custom_source_entry_field(key=key, value=value)

    def _append_custom_source_entry_field(self, key=None, value=None):
        row = Gtk.ListBoxRow(selectable=False, activatable=False)
        field = _CustomSourceEntryField(
            self.main, self._input_changed_callback, key, value
        )

        row.add(field)

        self.list_box_additional_fields.insert(row, -1)
        self.list_box_additional_fields.show_all()

    def _get_custom_source_entry_fields(self):
        rows = self.list_box_additional_fields.get_children()
        fields = [r.get_children()[0] for r in rows]

        return [f for f in fields if any((f.get_key(), f.get_val()))]

    def _is_current_input_valid(self):
        if '' in (self.entry_types.get_text(),
                  self.entry_uris.get_text(),
                  self.entry_suites.get_text(),
                  self.entry_comps.get_text()):
            return False

        for field in self._get_custom_source_entry_fields():
            if '' in (field.get_key(), field.get_val()):
                return False

        return True

    def _connect_signal_callbacks(self):
        for entry in (self.entry_types, self.entry_uris, self.entry_suites,
                      self.entry_comps, self.entry_comment):
            entry.connect('changed', self._input_changed_callback)

        self.button_add_field.connect('clicked',
                                      self._button_add_field_clicked_callback)

    def _input_changed_callback(self, *data):
        self.button_edit_ok.set_sensitive(self._is_current_input_valid())

    def _button_add_field_clicked_callback(self, *data):
        self._append_custom_source_entry_field()

    def _source_entry_from_input(self):
        source_entry = Deb822SourceEntry(None, self.source_entry.file)

        source_entry.types = self.entry_types.get_text().split()
        source_entry.uris = self.entry_uris.get_text().split()
        source_entry.suites = self.entry_suites.get_text().split()
        source_entry.comps = self.entry_comps.get_text().split()
        source_entry.comment = self.entry_comment.get_text()

        for field in self._get_custom_source_entry_fields():
            source_entry.section[field.get_key()] = field.get_val()

        return source_entry

    def run(self):
        res = self.main.run()
        if res == Gtk.ResponseType.OK:
            self.new_source_entry = self._source_entry_from_input()

        self.main.hide()

        return res
