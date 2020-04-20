format:
	~/.venvs/gdtoolkit/bin/gdformat --line-length 88 **/*.gd 

install_gdtoolkit:
	mkdir -p ~/.venvs/gdtoolkit/
	python3.8 -m venv ~/.venvs/gdtoolkit/
	~/.venvs/gdtoolkit/bin/python -m pip install gdtoolkit
