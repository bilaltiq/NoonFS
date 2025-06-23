# Group File System, Noon Edition

## Purpose

This repository contains a simple implementation of a file system with file-
reading capabilities. The system takes in a block device formatted using
the NevilleFS tool and loads files into RAM.

## Usage

This project uses Fivish and its commands.

To build, run:

```
(sys2) $ f-build combo.vmx kernel-stub.asm kernel.c stub-end.asm
```

To run the simulation, run:

```
(sys2) $ f-simulate bios.vmx combo.vmx
```

Additionally, create a symbolic link between test-1.bd and block-device.data as f-simulate looks for a "block-device.data"

```
(sys2) $ ln -s test-1.bd block-device.data
```

## Features

For this project, we were able to implement the following functions:

- [x] Allocate RAM space for file system initialization.
- [x] Interface with the block device to load blocks.
- [x] Load the superblock
- [x] Wrote functions for all tasks (including directory_search but not implemented).
- [x] Load the do-nothing.vmx file into it's own 32KB RAM space.

Here is the function structure which implements the high-level logic of
loading the file system into RAM.

### preload_fs()

Responsible for the following high-level operations: - allocating a 32 KB RAM space. - loading the superblock at the start of the of the RAM space.

- load the inode of the directory, replacing the contents of the superblock.
- load the first entry of the directory (do-nothing.vmx) into a new RAM
  space.

The "helper"/inner functions are:

### load_inode()

    -   takes in a block inode number and a pointer to a space in RAM
    -   calls load_bd_block to load the block data into RAM.

### load_bd_block()

    -   takes in a block number and pointer to space in RAM.
    -   input block number and trigger into block device interface
    -   DMA data from block device interface to space and RAM.

### load_file()

    -   takes in an inode struct
    -   allocates a new RAM block (32KB) for the file contents.
    -   iterate through blocks list in inode (repeatedly calling load_bd_block)
    -   shift the RAM pointer by 4KB after each load_bd_block.

### preload_directory()

    -   take in the directory inode block number
    -   load the directory inode
    -   load the file contents (inode blocks list)

## Future tasks

Given more time, we would implement the following features:

- [ ] Run do-nothing.vmx by eret-ing into it.
- [ ] Incorporate directory_search to read specific files by name.
- [ ] Bask in all the glory!

## First goal: Reading a whole file by name

The first concrete goal in implementing NevilleFS in our kernel is to implement _read-only capabilities_. Specifically, we seek the
ability to have our kernel load an executable image from a named file. To do so, we will need the following capabilities:

1. Reading and using the _superblock_.
2. Loading an _inode_.
3. Using an _inode_ to load a file's data blocks.
4. Reading the _directory_ (which is a file, so using the above).
5. Performing a _directory lookup_ for a given file name (e.g., `init`).
6. Using the above capabilities to then read the file's contents into a given 32 KB block.

We can imagine the highest-level code for loading an executable imagine from a file and into a block of RAM (where our blocks are
the 32 KB units organized in Project-2) to look something like the following (where, for brevity, I ignore good practices like
checking return values to see if the intermediate operations succeed):

```
  int do_run (char* filename) {

    /* Allocate a block for the process. */
    address_t process_memory_ptr = RAM_allocate();

    /* Load the executable image from the given file. */
    int image_length = get_length(filename);
    read(filename, 0, image_length, process_memory_ptr);

    /* Create the process_info for this new process and prepare the stack...*/
    /* Keep your Project-2 code for creating a new process here.*/

  }
```

We can imagine `get_length()` to be something like this:

```
  word_t get_length (char* filename) {

    /* Load the inode of the given file. */
    word_t   inode_block = directory_lookup(filename);
    inode_s* inode       = load_inode(inode_block);

    /* Return the length. */
    return inode->length;

  }
```

Now imagine what's needed for `directory_lookup()`:

```
  word_t directory_lookup (char* filename) {

    /* Load the directory file's inode. */
    superblock_s* superblock = load_superblock();
    inode_s*      dir_inode  = load_inode(superblock->directory_block);

    /* Load the directory file itself into a block.  (Assuming a directory <= 32 KB) */
    address_t directory_ptr = RAM_allocate();
    load_file(dir_inode, directory_ptr);
    directory_entry_s* directory = (directory_entry_s*)directory_ptr;
    word_t             entries   = dir_inode->length / sizeof(*directory);

    /* Do a lookup. */
    directory_entry_s* entry = directory_search(directory, filename);
    if (entry == NULL) {
      return NULL;
    } else {
      return entry->inode_block;
    }

  }
```

From these examples, we need to develop a handful of additional functions, including (perhaps)...

```
  address_t          RAM_allocate ()
  superblock_s*      load_superblock ()
  inode_s*           load_inode (word_t inode_block)
  void               load_file (inode_s* inode, address_t buffer)
  directory_entry_s* directory_search (directory_entry_s* directory_base, char* filename)
```

## To do:

Each member of this group should add their username (e.g., `sfkaplan`) at the end of one of these tasks. Spread out. Feel free to
take on a task as a pair with someone else in the group. _To avoid having everyone trying to edit the same file, each new function
should be written into its own `.c` file_, and I will merge them once first versions of them are done.

- [x] Write `preload_fs()` -> `everyone!`
- [x] Write/ prep `RAM_allocate` -> `@mtariq27`
- [x] Write `preload_superblock()` -> `@aguel26`
- [x] Write `preload_directory()` -> `@bdelgado27`
- [x] Write `load_bd_block()` -> `@aguel26`
- [x] Write `load_inode()` -> `@annab`
- [x] Write `load_file()` -> `bilal/ali`
- [x] Write `directory_search()` -> `dylan`
- [x] Clean up example functions above (`do_run()`, `get_length()`, `directory_lookup()`), using return values to handle errors
- [x] Choose a kernel from Project-2 as a starting point to which to add these functions.
