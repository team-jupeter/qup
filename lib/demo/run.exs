# mix run ./lib/demo/run.exs
alias Demo.Repo
alias Demo.Accounts.User
alias DemoWeb.Router.Helpers, as: Routes

for u <- Repo.all(User) do
  Repo.update!(User.registration_changeset(u, %{password: u.password_hash || "temppass" }))
end

# alias Demo.Repo
# alias Demo.Accounts.User
# Repo.insert(%User{name: "José", username: "josevalim", password_hash: "<3<3elixir"})
# Repo.insert(%User{name: "Bruce",username: "redrapids", password_hash: "7langs"})
# Repo.insert(%User{name: "Chris", username: "cmccord", password_hash: "phoenix"})

# alias Demo.Accounts.User
# alias DemoWeb.Router.Helpers, as: Routes

# changeset= User.registration_changeset(%User{}, %{username: "max", name: "Max", password: "123" })
# changeset= User.registration_changeset(%User{}, %{username: "max", name: "Max", password: "123 supersecret" })
# changeset.valid?
