# InteractiveConnectomes
Julia Pluto notebook for interactively exploring connectome data. 

## Setting up Julia 

First, download and install julia. You can do this by following instructions from [here](https://julialang.org/downloads/platform/#linux_and_freebsd). 

Depending on your system priviledges, you may need to set up an alias such as: 

`alias julia='/home/<username>/julia-1.5.3/bin/julia'`

If this has been installed correctly, starting a Julia REPL using `julia` should display version 1.5.3.

## Environment and Notebook

### Environment

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

### Running the Notebook

To run the notebook, exit the Pkg manager back to the julia REPL and use the following command: 

`using Pluto; Pluto.run()`

If you're working on a remote machine, make sure you set up the port forwarding: 

`ssh -L 1234:localhost:1234 <machine name>`

Note that Pluto will automatically open a notebook with port 1234. In the terminal, some config settings will appear, accept these with: 
`y`
`y`
`Shift + Q` 

A link should be displayed in the terminal. Open this in the browser and the notebook environment should appear. 

In the *Open from file* input, the path to the notebook `Notebooks/Networks.jl`

Once opened, the notebook will automatically execute the cells and you should be free to play around with the interactive UI! 

### Enjoy! 

