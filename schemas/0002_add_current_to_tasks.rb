schema "0002 add current to tasks" do
 
  entity "Task" do
    string :name, optional: false
    boolean :current, default: false, optional: false
  end
 
end
