class EmptyCell < UITableViewCell
    
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.styleClass = 'empty_cell'
      contentView.addSubview(empty_label)
    end
  end
  
  def empty_label
    @empty_label ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.styleClass = 'empty_label'
      label.text = "Click '+' to add your first task"
    end
  end
  
end