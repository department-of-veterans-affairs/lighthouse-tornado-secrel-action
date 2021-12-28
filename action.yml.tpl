# action.yml
name: 'SCA Wrapper Action'
description: 'Wraps SCA actions to allow for flexibility in defining SCA build tools/languages'

runs:
  using: 'composite'
  steps:
    - name: Run action
      uses: snyk/actions/$SNYK_ACTION_LANG@master
      with:
        command: $CMD
        args: $ARGS
