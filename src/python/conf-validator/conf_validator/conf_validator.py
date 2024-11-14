import sys
from pydantic import ValidationError
import typer
from Classes.EnvEnum import ModelType
from rich.console import Console

app = typer.Typer()
console = Console(color_system="truecolor", width=150)
err_console = Console(stderr=True, color_system="standard", width=150)

@app.command()
def validate(file:str, env:str):

    try:
        model = ModelType[env].value
    except KeyError as e:
        err_console.log(f"Invalid env: {e}", style="deep_pink2")
        return

    try:
        with open(file, "r") as file_stream:
            model.parse_raw(file_stream.read())
            console.log(f"VALIDATED ::: {file} :white_heavy_check_mark:", style="green_yellow")
    except FileNotFoundError as e:
        err_console.log(e, style="deep_pink2")
        sys.exit()
    except ValidationError as e:
        err_console.log(file, style="deep_pink2")
        err_console.print("A validation error occured :x:", style="deep_pink2")
        for error in e.errors():
            err_console.log(error["loc"], style="deep_pink2")
            err_console.log(error['msg'], style="deep_pink2")
        sys.exit(1)

if __name__ == "__main__":
    app()

