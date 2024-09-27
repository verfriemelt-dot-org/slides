---

# git hooks

```
[core]
  hooksPath = ~/.githooks
```

**https://git-scm.com/docs/githooks**

> Hooks are programs you can place in a hooks directory to trigger actions at certain points in git’s execution. Hooks that don’t have the executable bit set are ignored.

> By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed via the `core.hooksPath` configuration variable.

**hooks:**

 * applypatch-msg
 * pre-applypatch
 * post-applypatch
 * _pre-commit_
 * pre-merge-commit
 * _prepare-commit-msg_
 * commit-msg
 * post-commit
 * pre-rebase
 * post-checkout
 * post-merge
 * pre-push
 * pre-receive
 * update
 * proc-receive
 * post-receive
 * post-update
 * reference-transaction
 * push-to-checkout
 * pre-auto-gc
 * post-rewrite
 * sendemail-validate
 * fsmonitor-watchman
 * p4-changelist
 * p4-prepare-changelist
 * p4-post-changelist
 * p4-pre-submit
 * post-index-change

