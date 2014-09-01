
schema "0001 initial" do

  entity "Pomodoro" do

    datetime  :started_at, optional: false
    datetime  :finished_at
  end

end
