#!/bin/bash
set -e

# The install.sh script is the installation entrypoint for any features in this repository. 
#
# The tooling will parse the features.json + user devcontainer, and write 
# any build-time arguments into a feature-set scoped "features.env"
# The author is free to source that file and use it however they would like.
set -a
. ./features.env
set +a

if [ ! -z ${_BUILD_ARG_ZSH} ]; then
  echo "Activating zsh in your terminal"

  THEME="${_BUILD_ARG_ZSH_THEME:-https://github.com/denysdovhan/spaceship-prompt}"

  tee /usr/zsh.sh > /dev/null \
  << EOF
  #!/bin/bash
  apt-get update && apt-get install -y sudo curl gnupg locales zsh wget fonts-powerline
  # set up locale
  locale-gen en_US.UTF-8
  sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t ${THEME} \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    -p git \
    -p ssh-agent \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions
EOF

  chmod +x /usr/zsh.sh
  sudo cat '/usr/zsh.sh' > /usr/local/bin/zsh
  sudo chmod +x /usr/local/bin/zsh
fi
