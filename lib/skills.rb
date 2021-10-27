module Skills
  def strike(target)
    target.health -= self.power
  end
end