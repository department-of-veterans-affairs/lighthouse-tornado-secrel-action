# lighthouse-tornado-secrel-action
Wrapper for dynamic GitHub actions. Allows a workaround for GitHub not natively supporting variables in a `uses:` block.

## Implementation
- In your GitHub Workflow yml files, add the following code:
```
- uses: actions/checkout@v2
  with:
    repository: department-of-veterans-affairs/lighthouse-tornado-secrel-action
    path: sca

- name: Call env substitute
  env:
    SNYK_ACTION_LANG: ${{ inputs.languages }}
    CMD: test
    ARGS: --org=${{ inputs.snyk-org-name }} --sarif-file-output=sca.sarif --all-projects
  run: |
    envsubst < sca/action.yml.tpl > sca/action.yml
```
`envsubst` takes the `action.yml.tpl` and populates bash variables with their corresponding `env:` block values.

ie.,
```
runs:
  using: 'composite'
  steps:
    - name: Run action
      uses: snyk/actions/$SNYK_ACTION_LANG@master
      with:
        command: $CMD
        args: $ARGS
```
becomes:
```
runs:
  using: 'composite'
  steps:
    - name: Run action
      uses: snyk/actions/gradle@master
      with:
        command: test
        args: --org=rise8-pilot-org --sarif-file-output=sca.sarif --all-projects
```

The templated action is now callable via:
```
- name: Snyk SCA Results
  uses: ./sca   
```
