class EmptyCell < UITableViewCell
  
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'empty_cell'
      textLabel.text = "Click '+' to add your first task"
    end
  end
  
end