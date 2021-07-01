## Punchlist 🥊 + Tugboat 🚢 = ✨

This is [a docker image](https://hub.docker.com/r/q0rban/tugboat-punchlist) for use in a [Tugboat](https://www.tugboat.qa) project to
simplify connecting your project to [Punchlist](https://punchli.st/).

To connect your Tugboat project to Punchli.st:

1. [Create a new Punchlist project](https://app.punchli.st/projects/create)
2. [Generate a Punchlist API token](https://app.punchli.st/settings#/api)
3. Create two [custom environment variables](https://docs.tugboat.qa/setting-up-services/how-to-set-up-services/custom-environment-variables/) on your Tugboat Repository settings page:
   - `PUNCHLIST_PROJECT` with the ID of the project you created above
   - `PUNCHLIST_TOKEN` with the Punchlist API token from above
4. Add the following `punchlist` service to your Tugboat config.yml, replacing `[your-default-service]` with whatever your default service name is:

```yml
services:
  ...
  punchlist:
    image: q0rban/tugboat-punchlist
    depends:
      - [your-default-service]
    aliases:
      - punchlist
    expose: 80
    commands:
      clone:
        - punchlist-page-create
      online:
        - punchlist-page-create
```
