# Lem

Lem is the editor/IDE well-tuned for Common Lisp. <https://lem-project.github.io>

This is my notes from exploring some Lem codebase and few init files of other
people.

## Concepts

### Frame

The outermost display object.

### Window

Each pane which displays a buffer.

### Window tree

Arrangement of the windows.

- You can build a new arrangement and then set the window-tree of the frame to
    the new arrangement. 

### Point

It's a moveable location in the buffer. Looks like all the implementations are
based on operations on the points. Usually you can't create one directly, but
you can move existing points.
