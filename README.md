# InteractiveConnectomes
Julia Pluto notebook for interactively exploring connectome data. 

## Setting up Julia 

First, download and install julia. You can do this by following instructions from [here](https://julialang.org/downloads/platform/#linux_and_freebsd). 

Depending on your system priviledges, you may need to set up an alias such as: 

`alias julia='/home/<username>/julia-1.5.3/bin/julia'`

If this has been installed correctly, starting a Julia REPL using `julia` should display version 1.5.3.

## Environment and Notebook

The environment can easily be set up using the `project.toml` file. 

First, git clone the repo using the terminal: 

`git clone https://github.com/PavanChaggar/InteractiveConnectomes.git`

and `cd InteractiveConnectomes` into the directory. 

Next, start julia by running `julia`. 

Activate the environment by first entering the pkg mode by pressing `]` and then using: 

`activate .`

followed by: 
`instantiate` 

This will download the dependencies and *may take a while*. Use `status` to see that these have been installed and you can use `precompile` to precompile the packges, again, this *may take a while*. Hopefully this doesn't take too long since they're arent many large packages.

You can exit the pkg mode by hitting `return`. 





