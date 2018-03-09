from centos7dev:latest

LABEL maintainer zenotech

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 8090

USER dev
WORKDIR /workspace

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/bin/scl", "enable", "devtoolset-4", "--", "/usr/bin/scl", "enable", "rh-git29", "--", "/usr/bin/scl", "enable", "python27", "--"]

CMD ["/workspace/app/latest/bin/run_python", "/workspace/app/latest/bin/jupyter", "notebook", "--no-browser", "--port=8090", "--ip='*'"] 
