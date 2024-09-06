FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip

COPY . /app/notebook

WORKDIR /app/notebook

RUN pip install -e . \
    && npm install -g ijavascript \
    && ijsinstall

RUN mkdir -p /root/.jupyter \
    && echo "c.ContentsManager.hide_globs = ['app', 'CHANGELOG.md', 'docs', 'jupyter-notebook.desktop', 'LICENSE', 'notebook.svg', 'packages', 'RELEASE.md', 'tsconfigbase.json', 'ui-tests', 'yarn.lock', 'binder', 'CONTRIBUTING.md', 'jupyter-config', 'jupyter.svg', 'node_modules', 'nx.json', 'pyproject.toml', 'setup.py', 'tests', 'tsconfigbase.test.json', 'buildutils', 'Dockerfile', 'jupyter_config.json', 'lerna.json', 'notebook', 'package.json', 'README.md', 'tsconfig.eslint.json']" > /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]