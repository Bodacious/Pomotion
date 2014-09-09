
schema "0001 initial" do

  entity "Pomodoro" do
    datetime  :started_at, optional: false
    datetime  :finished_at
    belongs_to :task
  end
  
  entity "Task" do
    string :name, optional: false
    boolean :current, default: false, optional: false
    boolean :complete, default: false, optional: false
    has_many :pomodoros
  end

end
