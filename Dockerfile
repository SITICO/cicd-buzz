FROM jupyter/minimal-notebook
USER root
# Jupyter gateway support for Atom's Hydrogen package
RUN pip install jupyter_kernel_gateway
RUN jupyter notebook --generate-config -y
RUN mkdir /data
RUN sed -i "s|#c.NotebookApp.token = '<generated>'|c.NotebookApp.token = 'hbe_python_data_token'|g" /home/jovyan/.jupyter/jupyter_notebook_config.py
EXPOSE 8888
# run kernel gateway on container start, not notebook server
WORKDIR /data
CMD ["jupyter", "kernelgateway", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8888", "--JupyterWebsocketPersonality.list_kernels=True"]

