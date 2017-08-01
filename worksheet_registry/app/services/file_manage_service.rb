class FileManageService
  def get_file(filename, date)
    File.open(file_path(filename, date), 'rb')
  end

  def write_file(file, filename)
    new_file_name = file_name(filename)
    File.open(file_path(new_file_name), 'wb') { |f| f.write(file) }
    new_file_name
  end

  def file_path(file_name, dir = nil)
    File.join(dir.nil? ? directory : file_dir_path(dir), file_name)
  end

  def file_name(filename)
    [SecureRandom.uuid, filename].join('_')
  end

  def file_dir_path(date = Date.today.to_s)
    File.join(Rails.root, 'tmp', date)
  end

  def directory
    FileUtils.mkdir(file_dir_path, mode: 0777) unless Dir.exist? file_dir_path
    file_dir_path
  end
end
