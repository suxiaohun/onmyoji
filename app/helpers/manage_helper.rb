module ManageHelper
  def tip_list
    YysTip.all.order(id: :desc)
  end

  def patches_list
    YysPatch.all
  end
end
