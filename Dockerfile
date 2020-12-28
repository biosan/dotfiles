# syntax=docker/dockerfile:experimental

FROM nixos/nix:2.3.6


### Nix stuff

# Add home-manager channel
RUN nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# Add unstable channel
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable

# Update nixpkgs
RUN nix-channel --update

# Install home-manager
RUN export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
RUN nix-shell '<home-manager>' -A install


### Users and env vars
# ENV USERNAME=biosan \
#     PASSWORD=biosan \
#     USER_ID=1042

# ENV HOME=/home/${USERNAME}
# ENV DOTS=${HOME}/.config/nixpkgs

# # Create main user (without password)
# # RUN useradd -u ${USER_ID} -ms /bin/bash -G sudo ${USERNAME} && \
# #     passwd -d ${USERNAME}
# RUN adduser -D biosan

# # Set Dockerfile user and working directory
# USER ${USERNAME}
# WORKDIR ${HOME}

### Dotfiles

ENV DOTS=/root/.config/nixpkgs

# Copy dotfiles
COPY . ${DOTS}

# Install dotfiles
RUN home-manager switch

