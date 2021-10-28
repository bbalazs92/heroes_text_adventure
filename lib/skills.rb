module Skills

  def strike(target)
    target.health -= self.power
  end

  def heal
    self.health += 50
  end

end