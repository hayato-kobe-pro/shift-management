module RoomsHelper
  def check_time(name, time)
    print("===========")
    print(time)
    boolean = User.joins(:schedule).select('users.name,schedules.*').where({ name: name }).where('start_time LIKE ?', "%#{time}%")

    if boolean.empty?
      return "　"
    end
    return "◯"
  end
end
