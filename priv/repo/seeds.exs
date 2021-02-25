# Generates 100 seed users, each with 0 points.
for _ <- 1..100 do
  UserPoints.Accounts.create_user(%{points: 0})
end
