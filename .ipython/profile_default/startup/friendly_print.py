import builtins

from IPython.display import display


# Nicer printing, eg for dfs when printing in a for-loop or otherwise not the final cell value.
def print(*args, **kwargs):
    if not kwargs and len(args) == 1 and isinstance(args[0], str):
        builtins.print(args[0])
    else:
        display(*args, **kwargs)
