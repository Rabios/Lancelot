# Written by Rabia Alhaffar in 7/May/2021
# Lancelot, Tiny Game Launcher made for The Tool Jam in just 6 days
# Updated: 16/May/2021

# IDEA: If we have time we can add E key to edit info of game/list if possible, But doesn't mean i'll definitely do it.

# Returns first n elements of array
def first_arr_elemes(n, arr)
  res = []
  
  n.times.map do |i|
    if arr[i] == nil
      break
    else
      res << arr[i]
    end
  end
  
  return res
end

# Returns count of elements in array
def count(a, elem)
  res = 0
  
  a.length.times.map do |i|
    if a[i] == elem
      res += 1
    end
  end
  
  return res
end

# Generats list of genres!
def gen_genres_list(arr)
  res = {}
  
  arr.length.times.map do |i|
    res[arr[i].to_s] = count(arr, arr[i].to_s)
  end
  
  return res
end

# Checks if game with name exists
def game_exists(args)
  res = false
  
  if args.state.save1.games.length > 0
    args.state.save1.games.length.times do |i|
      if args.state.save1.games[i].name == args.state.game_name_textbox_str
        res = true
        break
      else
        res = false
      end
    end
  end
  
  return res
end

# Checks if list with name exists
def list_exists(args)
  res = false
  
  if args.state.save2.groups.length > 0
    args.state.save2.groups.length.times do |i|
      if args.state.save2.groups[i].name == args.state.add_group_textbox_str
        res = true
        break
      else
        res = false
      end
    end
  end
  
  return res
end

# Saves game data
def save_data args
  data0 = $gtk.serialize_state $gtk.args.state.as_hash.reject { |key, value|
    [:save0, :save1, :save2, :save3, :save4].include? key
  }
  
  data1 = $gtk.serialize_state(args.state.save0)
  data2 = $gtk.serialize_state(args.state.save1)
  data3 = $gtk.serialize_state(args.state.save2)
  data4 = $gtk.serialize_state(args.state.save3)
  data5 = $gtk.serialize_state(args.state.save4)
  
  $gtk.write_file("data/app_data0.txt", data0)
  $gtk.write_file("data/app_data1.txt", data1)
  $gtk.write_file("data/app_data2.txt", data2)
  $gtk.write_file("data/app_data3.txt", data3)
  $gtk.write_file("data/app_data4.txt", data4)
  $gtk.write_file("data/app_data5.txt", data5)
end

# Loads game data
def load_data args
  # Load save data from directories if exist
  data = $gtk.deserialize_state("data/app_data0.txt")
  save0 = $gtk.deserialize_state("data/app_data1.txt")
  save1 = $gtk.deserialize_state("data/app_data2.txt")
  save2 = $gtk.deserialize_state("data/app_data3.txt")
  save3 = $gtk.deserialize_state("data/app_data4.txt")
  save4 = $gtk.deserialize_state("data/app_data5.txt")
  
  if data
    $gtk.args.state = data
  end
  if save0
    $gtk.args.state.save0 = save0
  end
  if save1
    $gtk.args.state.save1 = save1
  end
  if save2
    $gtk.args.state.save2 = save2
  end
  if save3
    $gtk.args.state.save3 = save3
  end
  if save4
    $gtk.args.state.save4 = save4
  end
end

def play_spacebar_sound args
  if args.state.sounds_enabled == 1
    args.audio[:spacebar] ||= {
      input: "audio/421582__uberbosser__spacebarkey.wav",
      x: 0.0,
      y: 0.0,
      z: 0.0,
      gain: args.state.volume / 100,
      pitch: 1.0,
      paused: false,
      looping: false,
    }
  end
end

def play_typing_sound args
  if args.state.sounds_enabled == 1
    args.audio[:typing] ||= {
      input: "audio/180974__ueffects__a-key.wav",
      x: 0.0,
      y: 0.0,
      z: 0.0,
      gain: args.state.volume / 100,
      pitch: 1.0,
      paused: false,
      looping: false,
    }
  end
end

def play_back_sound args
  if args.state.sounds_enabled == 1
    args.audio[:back] ||= {
      input: "audio/538548__sjonas88__select-3.wav",
      x: 0.0,
      y: 0.0,
      z: 0.0,
      gain: args.state.volume / 100,
      pitch: 1.0,
      paused: false,
      looping: false,
    }
  end
end

def play_select_sound args
  if args.state.sounds_enabled == 1
    args.audio[:select] ||= {
      input: "audio/399934__old-waveplay__perc-short-click-snap-perc.wav",
      x: 0.0,
      y: 0.0,
      z: 0.0,
      gain: args.state.volume / 100,
      pitch: 1.0,
      paused: false,
      looping: false,
    }
  end
end

def play_pop_sound args
  if args.state.sounds_enabled == 1
    args.audio[:pop] ||= {
      input: "audio/244657__greenvwbeetle__pop-5.wav",
      x: 0.0,
      y: 0.0,
      z: 0.0,
      gain: args.state.volume / 100,
      pitch: 1.0,
      paused: false,
      looping: false,
    }
  end
end

# Substring from (index from ->> index to)
def substr(str, from, to)
  res = ""
  i = from
  
  while i < to + 1
    res << str[i]
    i += 1
  end
  
  return res
end

# Converts seconds to following format: <n>d <n>h <n>m <n>s
def secs_to_str(s)
  secs = s
  
  if secs > 43200
    days = secs.div(43200)
    days_to_secs = days * 43200
    secs -= days_to_secs
  end
  
  if secs > 3600
    hrs = secs.div(3600)
    hrs_to_secs = hrs * 3600
    secs -= hrs_to_secs
  end

  if secs > 60
    mins = secs.div(60)
    mins_to_secs = mins * 60
    secs -= mins_to_secs
  end

  return "#{days || 0}d #{hrs || 0}h #{mins || 0}m #{secs || 0}s"
end

# Windows Only: Detect partitions
def locate_drives()
  # HACK: NO FLOPPY (We can do it but Floppy now is dead, Sorry...)
  # If you want that, Just add "A" and "B" at beginning of array
  letters = [
    #"A", "B",   # Uncomment this line to enable floppy disks support!
    "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R",
    "S", "T", "U", "V", "W", "X", "Y", "Z",
  ]
  
  o = []
  
  letters.length.times.map do |i|
    if File.directory?("#{letters[i]}:\\")
      o << "#{letters[i]}:\\"
    end
  end
  
  return o
end

# Returns if file exist and is file an executable
def is_executable(args, path)
  count = 0
  
  if $gtk.platform == "Windows"
    exeformats = [ ".exe", ".com", ".bat", ".cmd" ]
    filename = "#{args.state.last_dir}\\#{path}"
  elsif $gtk.platform == "Mac Os X"
    exeformats = [ ".app", ".dmg" ]
    filename = "#{args.state.last_dir}/#{path}"
  else
    exeformats = [ ".elf", ".bin", "" ]
    filename = "#{args.state.last_dir}/#{path}"
  end
  
  if File.file?(filename)
    exeformats.length.times.map do |i|
      if File.extname(filename) == exeformats[i]
        count += 1
      end
    end
  end
  
  return count > 0
end

# Returns if file exist and is file an image
def is_image(args, path)
  imageformats = [ ".jpg", ".png", ".tga", ".bmp", ".psd", ".gif", ".hdr", ".pic" ]
  count = 0
  
  if $gtk.platform == "Windows"
    filename = "#{args.state.last_dir}\\#{path}"
  else
    filename = "#{args.state.last_dir}/#{path}"
  end
  
  if File.file?(filename)
    imageformats.length.times.map do |i|
      if File.extname(path) == imageformats[i]
        count += 1
      end
    end
  end
  
  return count > 0
end

# Combine chars from array to string, Designed as utility.
def combine_chars(arr)
  res = ""
  arr.length.times.map do |i|
    res << arr[i]
  end
  return res
end

# Returns true if string is numeric
def num_str(str)
  res = 0
  nums = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
  
  str.length.times.map do |i|
    nums.length.times.map do |j|
      if str[i] == nums[j]
        res += 1
      end
    end    
  end
  
  return res == str.length
end

# Returns true if process is running, This used by the Game Launcher to track time played.
def process_running(exename)
  if $gtk.platform == "Windows"
    return $gtk.exec("tasklist").include?(exename)
  else
    return $gtk.exec("ps axco cmd").split("\n").uniq.include?(exename)
  end
end

# Returns root dir or System Drive
# On Windows it should be C (Except if you have floppy enabled then it returns A or B if one of them exist, If both then A)
def root_dir()
  if $gtk.platform == "Windows"
    return locate_drives()[0]
  else
    return "/"
  end
end

# Counts number of slashes in directory
def count_dir_slashes(path)
  res = 0
  
  path.length.times do |s|
    if path[s] == "/" || path[s] == "\\"
      res += 1
    end
  end
  
  return res
end

# Returns directory of file path
def dir(path)
  slashes_count = count_dir_slashes(path)
  res = ""
  count = 0
  
  path.length.times do |s|
    if path[s] == "\\" || path[s] == "/"
      count += 1
    end
    
    if count < slashes_count
      res << path[s]
    end
  end
  
  return res
end

# Returns file name of path
def filename(path)
  if $gtk.platform == "Windows"
    return path.split("\\")[-1]
  else
    return path.split("/")[-1]
  end
end

# Returns previous directory of path
def prev_dir(path)
  slashes_count = count_dir_slashes(path)
  res = ""
  count = 0
  
  path.length.times do |s|
    if path[s] == "\\" || path[s] == "/"
      count += 1
    end
    
    if count < slashes_count - 1
      res << path[s]
    end
  end
  
  return res
end

# Fetches directory, Returning it's content
# NOTE: On Microsoft Windows it's hard to embed batchscript code so it uses something called cachedir.cmd
def fetch_dir(args, dir)
  if args.state.dirs_checked[-1] != dir
    args.state.dirs_checked << dir
    res = []
    files = []
    dirs = [ ".." ]
    content = []
    dir_counter = 0
    file_counter = 0
    
    if args.state.prev_dirs.length == 0
      dirs.pop
      #$gtk.log args.state.prev_dirs.length
    end

    if $gtk.platform == "Windows"
      fname = "#{args.state.wd}\\dirlist.txt"
      $gtk.exec("cachedir.cmd #{dir.quote}")
      
      File.open("dirlist.txt").each do |line|
        res << line.chomp
      end
    else
      dirlist = $gtk.exec("ls -1 #{dir.quote}")
      
      dirlist.each_line do |line|
        res << line.chomp
      end
    end

    res.length.times.map do |i|
      if $gtk.platform == "Windows"
        
        if File.directory?("#{args.state.last_dir}\\#{res[i]}")
          dirs << res[i]
          dir_counter += 1
        elsif File.file?("#{args.state.last_dir}\\#{res[i]}")
          files << res[i]
          file_counter += 1
        end
      else
        if File.directory?("#{args.state.last_dir}/#{res[i]}")
          dirs << res[i]
          dir_counter += 1
        elsif File.file?("#{args.state.last_dir}/#{res[i]}")
          files << res[i]
          file_counter += 1
        end
      end
    end
    
    args.state.last_dir = dir
    args.state.cd_files = files
    args.state.cd_dirs = dirs
    
    args.state.cd_dirs.length.times.map do |i|
      content << { name: args.state.cd_dirs[i], directory: 1 }
    end
    
    args.state.cd_files.length.times.map do |i|
      content << { name: args.state.cd_files[i], directory: 0 }
    end
    
    args.state.explorer_content = content
  end
end

# Returns file name without executable's extension, Can be used for process tracking 
def filename_no_exe(args, filename)
  return filename.delete_suffix(File.extname(filename))
end

# Combines genres from array returning them in one string!
def combine_genres_arr(genres)
  res = ""
  
  genres.length.times.map do |i|
    if (i == genres.length - 1)
      res << genres[i]
    else
      res << "#{genres[i]}, "
    end
  end
  
  return res
end

# Generates list for selecting games to add it to list
def genlist(args)
  res = []
  
  args.state.save1.games.length.times.map do |i|
    res << { name: args.state.save1.games[i].name, selected: 0 }
  end
  
  return res
end

# Draw background function
def draw_background args
  # Draw background
  args.outputs.primitives << {
    x: 0,
    y: args.state.custom_background == 1 ? 0 : -40,
    w: 1280,
    h: args.state.custom_background == 1 ? 720 : 760,
    path: args.state.custom_background == 1 ? args.state.save3.custom_background_path : args.state.save0.themes[args.state.default_theme_index].src
  }.sprite
end

# Main game loop
def tick args
  setup args
  
  # Load state
  if args.state.info_loaded == 0
    # If some important directory doesn't exist then create it!
    if !(File.exist?("data") && File.directory?("data"))
      $gtk.system("powershell mkdir data")
    end
    
    if !(File.exist?("data/images") && File.directory?("data/images"))
      $gtk.system("powershell mkdir data/images")
    end
    
    if !(File.exist?("data/backgrounds") && File.directory?("data/backgrounds"))
      $gtk.system("powershell mkdir data/backgrounds")
    end
    
    load_data args
    
    # Re-Initialize some values when loading from data (So it won't go to weird scene or stuck in something)
    args.state.current_scene = 0
    args.state.current_menu = 0
    args.state.movement_index = 0
    args.state.selection = 0
    args.state.options_menu_inselect = 0
    args.state.processes_count = 0
    args.state.playing_games = []
    args.state.info_loaded = 1
  end
  
  # Load fullscreen option
  if args.state.fullscreen == 1
    $gtk.set_window_fullscreen true
  else
    $gtk.set_window_fullscreen false
  end
  
  if args.state.current_scene == 0
    loading_scene args
  elsif args.state.current_scene == 1
    launcher_games args
  elsif args.state.current_scene == 2
    games_groups args
  elsif args.state.current_scene == 3
    launcher_stats args
  elsif args.state.current_scene == 4
    launcher_options args
  elsif args.state.current_scene == 5
    launcher_credits args
  elsif args.state.current_scene == 6
    add_game args
  elsif args.state.current_scene == 7
    launch_game args
  elsif args.state.current_scene == 8
    add_group args
  elsif args.state.current_scene == 9
    games_from_group args
  elsif args.state.current_scene == 10
    select_custom_background args
  end
  
  # TAB key: Move between menus
  if args.inputs.keyboard.key_down.tab
    play_select_sound args
    args.state.current_menu += 1
    if args.state.current_scene == 4
      args.state.current_menu = 0
      args.state.current_scene = 1
    elsif args.state.current_scene > 0 && args.state.current_scene < 4
      args.state.current_menu += 1
      args.state.current_scene += 1
    end
    
    args.state.stats_index = 0
    args.state.options_menu_inselect = 0
    args.state.options_menu_selection = 0
    args.state.lists_selection = 0
    args.state.groups_movement_index = 0
    args.state.selection = 0
    args.state.movement_index = 0
    args.state.processes_count = 0
  end
  
  # Draw FPS
  if args.state.fps_enabled == 1
    args.outputs.primitives << {
      x: 1160,
      y: 710,
      text: "FPS: " + args.gtk.current_framerate.to_i.to_s,
      font: "fonts/ubuntu-title.ttf",
      size_enum: 6,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
  
  # R key: Restart
  if args.inputs.keyboard.r
    if !(args.state.current_scene == 10 || args.state.current_scene == 8 || args.state.current_scene == 6)
      $gtk.reset seed: (Time.now.to_f * 100).to_i
    end
  end
  
  # ESC key: Back/Exit
  if args.inputs.keyboard.key_down.escape
    play_back_sound args
    if args.state.current_scene == 5
      args.state.options_menu_inselect = 0
      args.state.options_menu_selection = 0
      args.state.current_scene = 4
    elsif args.state.current_scene == 7
      args.state.current_scene = 1
      args.state.current_menu = 0
      args.state.selection = 0
      args.state.movement_index = 0
    end
  end
  
  if args.state.playing == 1
    if (args.state.tick_count % 60) == 0
      if args.state.playing_games.length > 0
        args.state.playing_games.length.times.map do |i|
          pf = filename_no_exe(args, filename(args.state.save1.games[args.state.playing_games[i].index].exepath))
      
          if (process_running(pf))
            args.state.save1.games[args.state.playing_games[i].index].time_played += 1
          else
            play_pop_sound args
            args.state.save1.games[args.state.playing_games[i].index].playing = 0
            args.state.playing_games.delete_at(i)
            args.state.processes_count -= 1
            data2 = $gtk.serialize_state(args.state.save1)
            $gtk.write_file("data/app_data2.txt", data2)
          end
        end
      end
    
      if args.state.processes_count <= 0
        args.state.playing = 0
      end
    end
  end
end

# Setup and initialize launcher variables
def setup args
  args.state.current_scene                  ||= 0
  args.state.current_menu                   ||= 0
  args.state.fullscreen                     ||= 0
  args.state.default_theme_index            ||= 0
  args.state.default_music_index            ||= 0
  args.state.sounds_enabled                 ||= 1
  args.state.music_enabled                  ||= 1
  args.state.volume                         ||= 100
  args.state.launch_game_selection          ||= 1
  args.state.time_played                    ||= 0
  args.state.loadbar_level                  ||= 0
  args.state.playing                        ||= 0
  args.state.movement_index                 ||= 0
  args.state.lists_selection                ||= 0
  args.state.groups_movement_index          ||= 0
  args.state.groups_games_selection         ||= 0
  args.state.groups_games_movement_index    ||= 0
  args.state.checking_process               ||= 0
  args.state.selections                     ||= 0
  args.state.selection                      ||= 0
  args.state.info_loaded                    ||= 0
  args.state.logs                           ||= 0
  args.state.add_group_textbox_substr       ||= ""
  args.state.add_group_textbox_str          ||= ""
  args.state.add_group_textbox_index        ||= 0
  args.state.game_name_textbox_substr       ||= ""
  args.state.game_name_textbox_str          ||= ""
  args.state.game_name_textbox_index        ||= 0
  args.state.game_genres_textbox_substr     ||= ""
  args.state.game_genres_textbox_str        ||= ""
  args.state.next_game_name                 ||= ""
  args.state.next_game_genres               ||= ""
  args.state.next_game_exeloader_dir        ||= ""
  args.state.next_game_exe_dir              ||= ""
  args.state.next_game_image_dir            ||= ""
  args.state.next_game_genres_textbox_index ||= 0
  args.state.call_index                     ||= 0
  args.state.add_game_scene                 ||= 0
  args.state.add_group_scene                ||= 0
  args.state.backspace_timer                ||= 0
  args.state.game_to_launch                 ||= nil
  args.state.group_to_play                  ||= nil
  args.state.grouphit                       ||= false
  args.state.groupview                      ||= false
  args.state.adding_game                    ||= false
  args.state.times_played                   ||= []
  args.state.playing_games                  ||= []
  args.state.menu_texts                     ||= [ "GAMES", "LISTS", "STATS", "OPTIONS" ]
  args.state.options_menu_selection         ||= 0
  args.state.options_menu_inselect          ||= 0
  args.state.games_list_selection           ||= 0
  args.state.games_list_movement_index      ||= 0
  args.state.stats_index                    ||= 0
  args.state.stats_names                    ||= [ "MOST GAMES PLAYED", "MOST RECENT GAMES PLAYED", "MOST TOTAL TIME PLAYED", "MOST GAME GENRES PLAYING" ]
  args.state.ranking                        ||= []
  args.state.wd                             ||= File._getwd()
  args.state.last_dir                       ||= root_dir()
  args.state.last_dir_substr                ||= ""
  args.state.input_dir_str                  ||= ""
  args.state.edit_dir_mode                  ||= 0
  args.state.input_dir_substr               ||= ""
  args.state.input_dir_index                ||= 0
  args.state.explorer_action                ||= 0
  args.state.prev_dirs                      ||= []
  args.state.explorer_content               ||= []
  args.state.explorer_movement_index        ||= 0
  args.state.dirs_checked                   ||= []
  args.state.cd_files                       ||= []
  args.state.cd_dirs                        ||= []
  args.state.custom_background              ||= 0
  args.state.save3.custom_background_path   ||= ""
  args.state.selecting_background           ||= false
  args.state.fps_enabled                    ||= 0
  args.state.game_index                     ||= 0
  args.state.processes_count                ||= 0
  
  # Themes
  args.state.save0.themes ||= [
    {
      src: "backgrounds/bg1.png",
      text_color: { r: 255, g: 255, b: 255 },
    },
    {
      src: "backgrounds/bg2.jpg",
      text_color: { r: 255, g: 255, b: 255 },
    },
    {
      src: "backgrounds/bg3.png",
      text_color: { r: 255, g: 255, b: 255 },
    },
    {
      src: "backgrounds/bg4.png",
      text_color: { r: 255, g: 255, b: 255 },
    },
    {
      src: "backgrounds/bg5.png",
      text_color: { r: 255, g: 255, b: 255 },
    },
    {
      src: "backgrounds/bg6.png",
      text_color: { r: 255, g: 255, b: 255 },
    },
    {
      src: "backgrounds/bg7.png",
      text_color: { r: 255, g: 255, b: 255 },
    },
    {
      src: "backgrounds/bg8.png",
      text_color: { r: 255, g: 255, b: 255 },
    },
  ]
  
  # Options menu rectangles used by options selection rectangle
  args.state.options_menu_recs ||= [
    { x: 214,  y: 214.from_top, w: 164, h: 64 },
    { x: 614,  y: 214.from_top, w: 164, h: 64 },
    { x: 1050, y: 214.from_top, w: 164, h: 64 },
    { x: 314,  y: 364.from_top, w: 164, h: 64 },
    { x: 314,  y: 464.from_top, w: 164, h: 64 },
    { x: 742,  y: 470.from_top, w: 512, h: 64 },
    { x: 552,  y: 570.from_top, w: 164, h: 64 },
    { x: 552,  y: 670.from_top, w: 164, h: 64 },
  ]
  
  # Games info stored here
  args.state.save1.games ||= []
  
  # Groups (Lists) info stored here
  args.state.save2.groups ||= []
  args.state.games_list ||= genlist(args)
  args.state.save4.genres_list ||= []
  args.state.genres_ranking_hash ||= {}
end

# Loading game scene
def loading_scene args
  if args.state.loadbar_level + 2 < 100
    args.state.loadbar_level += 2
  else
    args.state.current_scene = 1
    args.state.loadbar_level = 0
  end
  
  draw_background args
  
  # Draw title
  args.outputs.primitives << {
    x: 640 / 1.42,
    y: 20.from_top,
    text: "LANCELOT",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 48,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 640 / 1.9,
    y: 140.from_top,
    text: "Open-Source Game Launcher",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 16,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 16,
    y: 80,
    text: "Loading ...",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 16,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  # Draw loading bar
  args.outputs.primitives << {
    x: 0,
    y: 0,
    w: (args.state.loadbar_level / 10) * 128,
    h: 20,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.solid
end

# Time to Play! :)
def launcher_games args
  args.state.selections = args.state.save1.games.length + 1
  draw_menu args
  draw_games args
  launcher_games_input args
end

# Input of games menu
def launcher_games_input args
  if args.inputs.keyboard.key_down.left
    play_select_sound args
    if args.state.selection - 1 < 0
      args.state.selection = args.state.selections - 1
      args.state.movement_index = args.state.selections - 1
    else
      args.state.selection -= 1
      args.state.movement_index -= 1
    end
    
  elsif args.inputs.keyboard.key_down.right
    play_select_sound args
    if args.state.selection + 1 > args.state.selections - 1
      args.state.selection = 0
      args.state.movement_index = 0
    else
      args.state.selection += 1
      args.state.movement_index += 1
    end
    
  elsif args.inputs.keyboard.key_down.enter
    play_select_sound args
    # When pressing enter, There are 2 cases:
    # 1. Player in last selection: Go to "add new game" menu to add game
    # 2. Player not in last selection: Launch game
    if args.state.selection != args.state.selections - 1
      args.state.game_to_launch = args.state.save1.games[args.state.selection]
      args.state.current_scene = 7
    else
      if !args.state.adding_game
        args.state.add_game_scene = 0
        args.state.next_game_name = ""
        args.state.next_game_genres = ""
        args.state.next_game_exe_dir = ""
        args.state.next_game_exeloader_dir = ""
        args.state.next_game_image_dir = ""
        args.state.adding_game = true
        args.state.current_scene = 6
      end
    end
  elsif args.inputs.keyboard.key_down.delete
    # If DELETE key pressed, Delete game
    args.state.save1.games.delete_at(args.state.movement_index)
    $gtk.serialize_state("data/app_data2.txt", args.state.save1)
  end
end

# Lists menu
def games_groups args
  draw_menu args
  
  if !(args.state.save1.games.length > 0)
    args.outputs.primitives << {
      x: 340,
      y: 308.from_top,
      text: "NO GAMES! :(",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 48,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  else
    draw_lists args
    
    # + Add Game rectangle
    args.outputs.primitives << {
      x: (args.state.save2.groups.length - args.state.groups_movement_index) * 452 + 54,
      y: 400.from_top,
      w: 400,
      h: 200,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
  
    args.outputs.primitives << {
      x: (args.state.save2.groups.length - args.state.groups_movement_index) * 452 + 172,
      y: 195.from_top,
      text: "+",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 128,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label

    args.outputs.primitives << {
      x: (args.state.lists_selection - args.state.groups_movement_index) * 452 + 28,
      y: 424.from_top,
      w: 452,
      h: 252,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
    
    args.outputs.primitives << {
      x: 32,
      y: 280,
      text: (args.state.save2.groups[args.state.lists_selection] != nil) ? args.state.save2.groups[args.state.lists_selection].name : "ADD NEW LIST",
      size_enum: 16,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    games_groups_input args
  end  
end

# Draw created lists
def draw_lists args
  args.state.save2.groups.length.times.map do |i|
    args.outputs.primitives << {
      x: (i - args.state.groups_movement_index) * 452 + 55,
      y: 400.from_top,
      w: 400,
      h: 200,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
    
    args.outputs.primitives << {
      x: (i - args.state.groups_movement_index) * 452 + 196,
      y: 250.from_top,
      text: "##{i + 1}",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 36,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
end

# Lists menu input
def games_groups_input args
  if args.inputs.keyboard.key_down.left
    play_select_sound args
    if args.state.lists_selection - 1 < 0
      args.state.lists_selection = (args.state.save2.groups.length > 0 ? args.state.save2.groups.length : 0)
      args.state.groups_movement_index = (args.state.save2.groups.length > 0 ? args.state.save2.groups.length : 0)
    else
      args.state.lists_selection -= 1
      args.state.groups_movement_index -= 1
    end
    
  elsif args.inputs.keyboard.key_down.right
    play_select_sound args
    if args.state.lists_selection + 1 > args.state.save2.groups.length
      args.state.lists_selection = 0
      args.state.groups_movement_index = 0
    else
      args.state.lists_selection += 1
      args.state.groups_movement_index += 1
    end
    
  elsif args.inputs.keyboard.key_down.enter
    play_select_sound args
    
    # NOTE: Provided booleans here so you won't get stuck in some menu when getting back from another one
    if args.state.save2.groups.length > 0
      if args.state.lists_selection == args.state.save2.groups.length
        if !args.state.grouphit
          args.state.grouphit = true
          args.state.current_scene = 8
        end
      else
        if !args.state.groupview
          args.state.group_to_play = args.state.save2.groups[args.state.lists_selection]
          args.state.current_scene = 9
          args.state.groupview = true
        end
      end
    else
      if !args.state.grouphit
        args.state.grouphit = true
        args.state.current_scene = 8
      end
    end
  
  elsif !args.state.grouphit && !args.state.groupview && args.inputs.keyboard.key_down.delete
    args.state.save2.groups.delete_at(args.state.groups_movement_index)
    $gtk.serialize_state("data/app_data3.txt", args.state.save2)
  end
end

# Add list scene
def add_group args
  draw_background args
  
  args.outputs.primitives << {
    x: 640 / 1.6,
    y: 40.from_top,
    text: "Add new list",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 32,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  if args.state.add_group_scene == 0
    args.outputs.primitives << {
      x: 640 / 1.31,
      y: 280.from_top,
      text: "list name",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 22,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    if list_exists(args)
      args.outputs.primitives << {
        x: 420,
        y: 440.from_top,
        text: "LIST WITH THIS NAME EXISTS!",
        font: "fonts/ubuntu-title.ttf",
        size_enum: 8,
        r: 200,
        g: 0,
        b: 0,
        a: 255
      }.label
    end
  
    args.outputs.primitives << {
      x: 320,
      y: 420.from_top,
      w: 600,
      h: 64,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
    
    args.outputs.primitives << {
      x: 330,
      y: 360.from_top,
      text: args.state.add_group_textbox_substr,
      size_enum: 16,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 324 + args.state.add_group_textbox_index * 25.5,
      y: 412.from_top,
      w: 10,
      h: 48,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r + 50,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.solid
  
    args.outputs.primitives << {
      x: 16,
      y: 64,
      text: "[ESCAPE] BACK",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  
    args.outputs.primitives << {
      x: 1022,
      y: 64,
      text: "[ENTER] NEXT",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  elsif args.state.add_group_scene == 1
    args.outputs.primitives << {
      x: 32,
      y: 180.from_top,
      text: "select games to add",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 14,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 32,
      y: 240.from_top,
      w: 600,
      h: 5,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.solid
    
    draw_games_list args
    
    args.outputs.primitives << {
      x: (args.state.games_list_selection - args.state.games_list_movement_index) * 452 + 28,
      y: 524.from_top,
      w: 452,
      h: 252,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
    
    if args.state.games_list_selection != args.state.games_list.length
      args.outputs.primitives << {
        x: 64,
        y: 180,
        text: args.state.save1.games[args.state.games_list_selection].name,
        font: "fonts/ubuntu-title.ttf",
        size_enum: 16,
        r: args.state.games_list[args.state.games_list_selection].selected == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.games_list[args.state.games_list_selection].selected == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    end
    
    args.outputs.primitives << {
      x: (args.state.games_list.length - args.state.games_list_movement_index) * 452 + 56,
      y: 500.from_top,
      w: 400,
      h: 200,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
    
    args.outputs.primitives << {
      x: (args.state.games_list.length - args.state.games_list_movement_index) * 452 + 172,
      y: 350.from_top,
      text: "DONE",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 32,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 16,
      y: 48,
      text: "[ESCAPE] BACK",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 8,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  
    args.outputs.primitives << {
      x: 800,
      y: 48,
      text: "[ENTER] SELECT/DESELECT",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 8,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
  
  add_group_input args
end

# Add list scene menu input
def add_group_input args
  if args.state.add_group_scene == 0
    if args.inputs.text[0].to_s != ""
      if args.inputs.text[0].to_s == " "
        play_spacebar_sound args
      else
        play_typing_sound args
      end
      
      args.state.add_group_textbox_str << args.inputs.text[0].to_s
    
      if args.state.add_group_textbox_str.length > 23
        args.state.add_group_textbox_substr = substr(args.state.add_group_textbox_str, args.state.add_group_textbox_str.length - 24, args.state.add_group_textbox_str.length - 1)
      else
        args.state.add_group_textbox_substr = args.state.add_group_textbox_str
        args.state.add_group_textbox_index += 1
      end
    end
  
    if args.inputs.keyboard.backspace
      args.state.backspace_timer += 1
      
      if args.state.backspace_timer == 8
        args.state.add_group_textbox_str = args.state.add_group_textbox_str.chop
        
        if !(args.state.add_group_textbox_index - 1 < 0) && args.state.add_group_textbox_str.length < 24
          args.state.add_group_textbox_index -= 1
        end
        args.state.backspace_timer = 0
      end
      
      if args.state.add_group_textbox_str.length > 23
        args.state.add_group_textbox_substr = substr(args.state.add_group_textbox_str, args.state.add_group_textbox_str.length - 24, args.state.add_group_textbox_str.length - 1)
      else
        args.state.add_group_textbox_substr = substr(args.state.add_group_textbox_str, 0, args.state.add_group_textbox_str.length - 1)
      end
    end
    
    if !list_exists(args)
      if args.inputs.keyboard.key_down.enter
        play_select_sound args
        args.state.games_list = genlist(args)
        args.state.games_list_movement_index = 0
        args.state.games_list_selection = 0
        args.state.add_group_scene = 1
      end
    end
    
    if args.inputs.keyboard.key_down.escape
      play_back_sound args
      args.state.grouphit = false
      args.state.groupview = false
      args.state.current_scene = 2
      args.state.lists_selection = 0
      args.state.groups_movement_index = 0
      args.state.games_list_selection = 0
      args.state.games_list_movement_index = 0
      args.state.add_group_textbox_index = 0
      args.state.add_group_scene = 0
      args.state.add_group_textbox_str = ""
      args.state.add_group_textbox_substr = ""
      args.state.lists_selection = ((args.state.lists.length > 0) ? args.state.lists.length : 1) - 1
    end
  elsif args.state.add_group_scene == 1
    if args.inputs.keyboard.key_down.left
      play_select_sound args
      if args.state.games_list_selection - 1 < 0
        args.state.games_list_selection = args.state.save1.games.length
        args.state.games_list_movement_index = args.state.save1.games.length
      else
        args.state.games_list_selection -= 1
        args.state.games_list_movement_index -= 1
      end
    end
    
    if args.inputs.keyboard.key_down.right
      play_select_sound args
      if args.state.games_list_selection + 1 > args.state.save1.games.length
        args.state.games_list_selection = 0
        args.state.games_list_movement_index = 0
      else
        args.state.games_list_selection += 1
        args.state.games_list_movement_index += 1
      end
    end
    
    if args.inputs.keyboard.key_down.escape
      play_back_sound args
      args.state.grouphit = true
      args.state.current_scene = 8
      args.state.lists_selection = 0
      args.state.groups_movement_index = 0
      args.state.games_list_selection = 0
      args.state.games_list_movement_index = 0
      args.state.add_group_textbox_index = 0
      args.state.add_group_scene = 0
      args.state.add_group_textbox_str = ""
      args.state.add_group_textbox_substr = ""
    end
    
    if args.inputs.keyboard.key_down.enter
      play_select_sound args
      if args.state.games_list_selection != args.state.save1.games.length
        args.state.games_list[args.state.games_list_selection].selected = args.state.games_list[args.state.games_list_selection].selected == 1 ? 0 : 1
      else
        selected_games = []
        
        args.state.games_list.length.times.map do |i|
          if args.state.games_list[i].selected == 1
            selected_games << args.state.save1.games[i]
          end
          args.state.games_list[i].selected = 0
        end
        
        args.state.save2.groups << {
          name: args.state.add_group_textbox_str,
          games: selected_games
        }
        
        args.state.games_list = genlist(args)
        args.state.grouphit = false
        args.state.groupview = false
        args.state.current_scene = 2
        args.state.lists_selection = 0
        args.state.groups_movement_index = 0
        args.state.games_list_selection = 0
        args.state.games_list_movement_index = 0
        args.state.add_group_textbox_index = 0
        args.state.add_group_scene = 0
        args.state.add_group_textbox_str = ""
        args.state.add_group_textbox_substr = ""
        
        save_data args
      end
    end
  end
end

# Display games of list
def games_from_group args
  draw_background args
  
  args.outputs.primitives << {
    x: 16,
    y: 16.from_top,
    text: "SELECT GAME TO PLAY",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 24,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 16,
    y: 102.from_top,
    w: 600,
    h: 5,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.solid
  
  draw_games_from_group args
  
  args.outputs.primitives << {
    x: (args.state.groups_games_selection - args.state.groups_games_movement_index) * 452 + 28,
    y: 424.from_top,
    w: 452,
    h: 252,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 32,
    y: 280,
    text: args.state.group_to_play.games[args.state.groups_games_selection].name,
    size_enum: 16,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  if args.state.group_to_play.games[args.state.selection].playing != nil
    args.outputs.primitives << {
      x: 32,
      y: 220,
      text: args.state.group_to_play.games[args.state.selection].playing == 1 ? "PLAYING" : "",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 6,
      r: args.state.save1.games[args.state.selection].playing == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save1.games[args.state.selection].playing == 1 ? 150 : args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save1.games[args.state.selection].playing == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
  
  args.outputs.primitives << {
    x: 16,
    y: 64,
    text: "[ESCAPE] BACK",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 1000,
    y: 64,
    text: "[ENTER] SELECT",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  games_from_group_input args
end

# Draw games of list
def draw_games_from_group args
  # How long is this line? Do you think it can beat Great Wall of China?
  args.state.group_to_play.games.length.times.map do |i|
    args.outputs.primitives << {
      x: (i - args.state.groups_games_movement_index) * 452 + 55,
      y: 400.from_top,
      w: 400,
      h: 200,
      path: args.state.group_to_play.games[i].image,
    }.sprite
  end
end

# Recieve input from list of games
def games_from_group_input args
  if args.inputs.keyboard.key_down.left
    play_select_sound args
    if args.state.groups_games_selection - 1 < 0
      args.state.groups_games_selection = args.state.group_to_play.games.length - 1
      args.state.groups_games_movement_index = args.state.group_to_play.games.length - 1
    else
      args.state.groups_games_selection -= 1
      args.state.groups_games_movement_index -= 1
    end
  elsif args.inputs.keyboard.key_down.right
    play_select_sound args
    if args.state.groups_games_selection + 1 > args.state.group_to_play.games.length - 1
      args.state.groups_games_selection = 0
      args.state.groups_games_movement_index = 0
    else
      args.state.groups_games_selection += 1
      args.state.groups_games_movement_index += 1
    end
  elsif args.inputs.keyboard.key_down.enter
    play_select_sound args
    args.state.game_to_launch = args.state.group_to_play.games[args.state.groups_games_selection]
    args.state.current_scene = 7
    args.state.groups_games_selection = 0
    args.state.groups_games_movement_index = 0
    args.state.games_list_movement_index = 0
    args.state.games_list_selection = 0
    args.state.groupview = false
  elsif args.inputs.keyboard.key_down.escape
    play_back_sound args
    args.state.current_scene = 2
    args.state.groups_games_movement_index = 0
    args.state.groups_games_selection = 0
    args.state.lists_selection = 0
    args.state.games_list_movement_index = 0
    args.state.games_list_selection = 0
    args.state.groupview = false
  end
end

# Stats (Ranking) menu
def launcher_stats args
  draw_menu args
  stx = 0 # Stat's text x pos depends on index of stat
  
  if args.state.stats_index == 0
    stx = 416  
  elsif args.state.stats_index == 1
    stx = 358
  elsif args.state.stats_index == 2
    stx = 378
  elsif args.state.stats_index == 3
    stx = 358
  end
  
  args.outputs.primitives << {
    x: stx,
    y: 164.from_top,
    text: "< #{args.state.stats_names[args.state.stats_index]} >",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 32,
    y: 148.from_top,
    w: 1212,
    h: 5,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.solid
  
  args.outputs.primitives << {
    x: 32,
    y: 228.from_top,
    w: 1212,
    h: 5,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.solid
  
  launcher_stats_ranking args
  launcher_stats_draw_rankings args
  launcher_stats_input args
end

# Stats menu input
def launcher_stats_input args
  if args.inputs.keyboard.key_down.left
    play_select_sound args
    if args.state.stats_index - 1 < 0
      args.state.stats_index = args.state.stats_names.length - 1
    else
      args.state.stats_index -= 1
    end
  elsif args.inputs.keyboard.key_down.right
    play_select_sound args
    if args.state.stats_index + 1 < args.state.stats_names.length
      args.state.stats_index += 1
    else
      args.state.stats_index = 0
    end
  end
end

# Sort by genres
def games_by_genres_played args
  res = []
  
  ls = gen_genres_list(args.state.save4.genres_list)
  ls.sort_by { |k, v| v }.reverse
  
  ls.length.times.map do |i|
    res << { name: ls.keys[i], value: ls[ls.keys[i]] }
  end
  
  args.state.ranking = first_arr_elemes(10, res)
end

# Sort games by times played (Count)
def games_by_times_played args
  res = []
  
  args.state.save1.games.length.times.map do |i|
    if args.state.save1.games[i].times_played != nil
      res << {
        name: args.state.save1.games[i].name,
        value: args.state.save1.games[i].times_played
      }
    end
  end
  
  args.state.ranking = first_arr_elemes(10, res.sort_by { |hash| hash[:value] }.reverse)
end

# Sort game by recently played
# NOTE: To do this magic i used variable that increases it's value when playing a game and then set value to that game's Hash
def games_by_recent_played args
  res = []
  
  args.state.save1.games.length.times.map do |i|
    if args.state.save1.games[i].launch_index != nil
      res << {
        name: args.state.save1.games[i].name,
        value: args.state.save1.games[i].launch_index
      }
    end
  end
  
  args.state.ranking = first_arr_elemes(10, res.sort_by { |hash| hash[:value] }.reverse)
end

def games_by_total_time_played args
  res = []
  
  args.state.save1.games.length.times.map do |i|
    if args.state.save1.games[i].time_played != nil
      res << {
        name: args.state.save1.games[i].name,
        value: args.state.save1.games[i].time_played
      }
    end
  end
  
  args.state.ranking = first_arr_elemes(10, res.sort_by { |hash| hash[:value] }.reverse)
end

# Run sort function depending on index of stat
def launcher_stats_ranking args
  if args.state.stats_index == 0
    games_by_times_played args
  elsif args.state.stats_index == 1
    games_by_recent_played args
  elsif args.state.stats_index == 2
    games_by_total_time_played args
  elsif args.state.stats_index == 3
    games_by_genres_played args
  end
end

# Draw ranks for stats menu
def launcher_stats_draw_rankings args
  args.state.ranking.length.times.map do |i|
    args.outputs.primitives << {
      x: 32,
      y: (240 + (i * 48)).from_top,
      text: "##{i + 1}",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 6,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 128,
      y: (240 + (i * 48)).from_top,
      text: args.state.ranking[i].name,
      size_enum: 6,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    if args.state.stats_index == 0
      args.outputs.primitives << {
        x: 600,
        y: (240 + (i * 48)).from_top,
        text: args.state.ranking[i].value.to_s,
        size_enum: 6,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    elsif args.state.stats_index == 2
      args.outputs.primitives << {
        x: 600,
        y: (240 + (i * 48)).from_top,
        text: secs_to_str(args.state.ranking[i].value),
        size_enum: 6,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    end
  end
end

# Options menu
def launcher_options args
  draw_menu args
  
  # fullscreen clear data
  args.outputs.primitives << {
    x: 32,
    y: 150.from_top,
    text: "SOUNDS: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 270,
    y: 160.from_top,
    text: args.state.sounds_enabled == 1 ? "ON" : "OFF",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 214,
    y: 214.from_top,
    w: 164,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 462,
    y: 150.from_top,
    text: "music: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 670,
    y: 160.from_top,
    text: args.state.music_enabled == 1 ? "ON" : "OFF",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 614,
    y: 214.from_top,
    w: 164,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 862,
    y: 150.from_top,
    text: "volume: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 1105,
    y: 160.from_top,
    text: args.state.volume,
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 1050,
    y: 214.from_top,
    w: 164,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 32,
    y: 300.from_top,
    text: "fullscreen: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 372,
    y: 310.from_top,
    text: args.state.fullscreen == 1 ? "ON" : "OFF",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 314,
    y: 364.from_top,
    w: 164,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 32,
    y: 400.from_top,
    text: "background: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 388,
    y: 410.from_top,
    text: args.state.default_theme_index + 1,
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.borders << {
    x: 742,
    y: 470.from_top,
    w: 512,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 758,
    y: 415.from_top,
    text: "Select Custom Background",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 314,
    y: 464.from_top,
    w: 164,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 560,
    y: 522.from_top,
    text: "view credits",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 4,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 552,
    y: 570.from_top,
    w: 164,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 572,
    y: 622.from_top,
    text: "clear data",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 4,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 552,
    y: 670.from_top,
    w: 164,
    h: 64,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: args.state.options_menu_recs[args.state.options_menu_selection].x - 16,
    y: args.state.options_menu_selection == 5 ? args.state.options_menu_recs[args.state.options_menu_selection].y - 16 : args.state.options_menu_recs[args.state.options_menu_selection].y - 16,
    w: args.state.options_menu_recs[args.state.options_menu_selection].w + 32,
    h: args.state.options_menu_recs[args.state.options_menu_selection].h + 32,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  if args.state.options_menu_inselect == 1
    args.outputs.primitives << {
      x: 16,
      y: 112,
      text: "[UP/DOWN] CHANGE VALUE",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 8,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
  
  launcher_options_input args
end

def launcher_options_input args
  if args.state.options_menu_inselect == 0
    if args.inputs.keyboard.key_down.left || args.inputs.keyboard.key_down.up
      play_select_sound args
      if args.state.options_menu_selection - 1 < 0
        args.state.options_menu_selection = args.state.options_menu_recs.length - 1
      else
        args.state.options_menu_selection -= 1
      end
    elsif args.inputs.keyboard.key_down.right || args.inputs.keyboard.key_down.down
      play_select_sound args
      if args.state.options_menu_selection + 1 < args.state.options_menu_recs.length
        args.state.options_menu_selection += 1 
      else
        args.state.options_menu_selection = 0
      end
    elsif args.inputs.keyboard.key_up.enter
      play_select_sound args
      if args.state.options_menu_selection == 0
        args.state.sounds_enabled = args.state.sounds_enabled == 1 ? 0 : 1
      elsif args.state.options_menu_selection == 1
        args.state.music_enabled = args.state.music_enabled == 1 ? 0 : 1
      elsif args.state.options_menu_selection == 2
        args.state.options_menu_inselect = 1
      elsif args.state.options_menu_selection == 3
        args.state.fullscreen = args.state.fullscreen == 1 ? 0 : 1
      elsif args.state.options_menu_selection == 4
        args.state.options_menu_inselect = 1
      elsif args.state.options_menu_selection == 5
        args.state.last_dir = root_dir()
        args.state.explorer_action = 3
        args.state.selecting_background = true
        args.state.current_scene = 6
        args.state.add_game_scene = 2
      elsif args.state.options_menu_selection == 6
        args.state.current_scene = 5
      elsif args.state.options_menu_selection == 7
        args.state.movement_index                 = 0
        args.state.selection                      = 0
        args.state.lists_selection                = 0
        args.state.groups_movement_index          = 0
        args.state.fullscreen                     = 0
        args.state.default_theme_index            = 0
        args.state.default_music_index            = 0
        args.state.edit_dir_mode                  = 0
        args.state.sounds_enabled                 = 1
        args.state.music_enabled                  = 1
        args.state.volume                         = 100
        args.state.custom_background              = 0
        args.state.save3.custom_background_path         = ""
        args.state.save1.games                    = []
        args.state.save2.groups                   = []
        args.state.played_games                   = []
        args.state.playing_games                  = []
        args.state.ranking                        = []
        args.state.time_played                    = 0
        args.state.playing                        = 0
        args.state.lists_selection                = 0
        args.state.groups_movement_index          = 0
        args.state.groups_games_selection         = 0
        args.state.groups_games_movement_index    = 0
        args.state.add_group_textbox_substr       = ""
        args.state.add_group_textbox_str          = ""
        args.state.add_group_textbox_index        = 0
        args.state.game_name_textbox_substr       = ""
        args.state.game_name_textbox_str          = ""
        args.state.game_name_textbox_index        = 0
        args.state.game_genres_textbox_substr     = ""
        args.state.game_genres_textbox_str        = ""
        args.state.next_game_name                 = ""
        args.state.next_game_genres               = ""
        args.state.next_game_exeloader_dir        = ""
        args.state.next_game_exe_dir              = ""
        args.state.next_game_image_dir            = ""
        args.state.next_game_genres_textbox_index = 0
        args.state.call_index                     = 0
        args.state.add_game_scene                 = 0
        args.state.add_group_scene                = 0
        args.state.backspace_timer                = 0
        args.state.game_to_launch                 = nil
        args.state.group_to_play                  = nil
        args.state.grouphit                       = false
        args.state.groupview                      = false
        args.state.adding_game                    = false
        args.state.times_played                   = []
        args.state.played_games                   = []
        args.state.playing_games                  = []
        args.state.options_menu_selection         = 0
        args.state.options_menu_inselect          = 0
        args.state.games_list_selection           = 0
        args.state.games_list_movement_index      = 0
        args.state.stats_index                    = 0
        args.state.ranking                        = []
        args.state.wd                             = File._getwd()
        args.state.last_dir                       = root_dir()
        args.state.last_dir_substr                = root_dir()
        args.state.input_dir_str                  = ""
        args.state.edit_dir_mode                  = 0
        args.state.input_dir_substr               = ""
        args.state.input_dir_index                = 0
        args.state.explorer_action                = 0
        args.state.prev_dirs                      = []
        args.state.explorer_content               = []
        args.state.explorer_movement_index        = 0
        args.state.selecting_background           = false
        args.state.processes_count                = 0
      end
      
      if args.state.options_menu_selection != 2 && args.state.options_menu_selection != 4
        save_data args
      end
    end
  else
    if args.state.options_menu_selection == 2
      if args.inputs.keyboard.key_down.up
        if !(args.state.volume + 1 > 100)
          args.state.volume += 1
        end
      elsif args.inputs.keyboard.key_down.down
        if !(args.state.volume - 1 < 0)
          args.state.volume -= 1
        end
      end
    elsif args.state.options_menu_selection == 4
      if args.inputs.keyboard.key_down.up
        if (args.state.default_theme_index + 1 < args.state.save0.themes.length)
          args.state.default_theme_index += 1
        else
          args.state.default_theme_index = 0
        end
        
      elsif args.inputs.keyboard.key_down.down
        if (args.state.default_theme_index - 1 >= 0)
          args.state.default_theme_index -= 1
        else
          args.state.default_theme_index = args.state.save0.themes.length - 1
        end
      end
    end
  
    if args.inputs.keyboard.key_up.enter
      args.state.options_menu_inselect = 0
      
      if args.state.options_menu_selection == 4
        args.state.custom_background = 0
        args.state.save3.custom_background_path = ""
      end
      
      save_data args
    end
  
    if args.inputs.keyboard.key_down.tab
      play_select_sound args
      args.state.current_menu = 0  
    end
  end
end

# Credits
def launcher_credits args
  draw_background args
  
  args.outputs.primitives << {
    x: 640 / 1.42,
    y: 20.from_top,
    text: "LANCELOT",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 48,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 32,
    y: 190.from_top,
    text: "CREATED BY",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 22,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 32,
    y: 270.from_top,
    w: 400,
    h: 5,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.solid
  
  args.outputs.primitives << {
    x: 32,
    y: 280.from_top,
    text: "Rabia Alhaffar",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 8,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 720 / 1.9,
    y: 120.from_top,
    text: "Open-Source Game Launcher",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 32,
    y: 360.from_top,
    text: "POWERED BY",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 22,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 32,
    y: 440.from_top,
    w: 400,
    h: 5,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.solid
  
  args.outputs.primitives << {
    x: 32,
    y: 450.from_top,
    text: "DragonRuby GTK",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 8,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 32,
    y: 500.from_top,
    text: "Powershell - Bash - Batchscript",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 8,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 16,
    y: 64,
    text: "[ESCAPE] BACK TO OPTIONS MENU",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 8,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 1280 - 84,
    y: 700.from_top,
    w: 64,
    h: 64,
    path: "sprites/icon.png"
  }.sprite
  
  if args.inputs.mouse.click && args.inputs.mouse.button_left
    if ({ x: args.inputs.mouse.x, y: args.inputs.mouse.y, w: 1, h: 1 }).intersect_rect?({ x: 1280 - 84, y: 700.from_top, w: 64, h: 64 })
      $gtk.openurl "https://dragonruby.org"
    end
  end
end

# Draw games list for games menu
def draw_games args
  if args.state.save1.games.length > 0
    args.state.save1.games.length.times.map do |i|
      args.outputs.primitives << {
        x: (i - args.state.movement_index) * 452 + 55,
        y: 400.from_top,
        w: 400,
        h: 200,
        path: args.state.save1.games[i].image,
      }.sprite
    end
  end
  
  draw_gui args
end

def draw_games_list args
  if args.state.save1.games.length > 0
    args.state.save1.games.length.times.map do |i|

      args.outputs.primitives << {
        x: (i - args.state.games_list_movement_index) * 452 + 55,
        y: 500.from_top,
        w: 400,
        h: 200,
        path: args.state.save1.games[i].image,
      }.sprite
      
      args.outputs.primitives << {
        x: (i - args.state.games_list_movement_index) * 452 + 55,
        y: 500.from_top,
        w: 400,
        h: 200,
        r: args.state.games_list[i].selected == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.games_list[i].selected == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.border
      
      args.outputs.primitives << {
        x: (i - args.state.games_list_movement_index) * 452 + 55,
        y: 316.from_top,
        w: 16,
        h: 16,
        r: args.state.games_list[i].selected == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.games_list[i].selected == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.solid
    end
  end
end

# Add Game scene
# DEV NOTE: Selecting custom background scene uses this but i added explorer_action 3 with will does it tricky!
def add_game args
  draw_background args
  
  if args.state.add_game_scene < 2
    args.outputs.primitives << {
      x: 640 / 1.65,
      y: 40.from_top,
      text: "Add new game",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 32,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
  
  if args.state.add_game_scene == 0
    args.outputs.primitives << {
      x: 510,
      y: 250.from_top,
      text: "GAME NAME",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 18,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 350,
      y: 400.from_top,
      w: 600,
      h: 64,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
    
    args.outputs.primitives << {
      x: 360 + args.state.game_name_textbox_index * 25.2,
      y: 392.from_top,
      w: 10,
      h: 48,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r + 50,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.solid
    
    args.outputs.primitives << {
      x: 360,
      y: 342.from_top,
      text: args.state.game_name_textbox_substr,
      size_enum: 16,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r + 50,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label

    args.outputs.primitives << {
      x: 16,
      y: 64,
      text: "[ESCAPE] BACK",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 1025,
      y: 64,
      text: "[ENTER] NEXT",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    if game_exists(args)
      args.outputs.primitives << {
        x: 440,
        y: 420.from_top,
        text: "GAME WITH THIS NAME EXISTS!",
        font: "fonts/ubuntu-title.ttf",
        size_enum: 8,
        r: 200,
        g: 0,
        b: 0,
        a: 255
      }.label
    end
  elsif args.state.add_game_scene == 1
    args.outputs.primitives << {
      x: 500,
      y: 250.from_top,
      text: "GAME GENRES",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 18,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 380,
      y: 420.from_top,
      text: "(Split each genre with , and space)",
      size_enum: 6,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 350,
      y: 400.from_top,
      w: 600,
      h: 64,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border

    args.outputs.primitives << {
      x: 360 + args.state.game_genres_textbox_index * 25.2,
      y: 392.from_top,
      w: 10,
      h: 48,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r + 50,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.solid
    
    args.outputs.primitives << {
      x: 360,
      y: 342.from_top,
      text: args.state.game_genres_textbox_substr,
      size_enum: 16,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r + 50,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 16,
      y: 64,
      text: "[ESCAPE] BACK",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 1025,
      y: 64,
      text: "[ENTER] NEXT",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  elsif args.state.add_game_scene == 2
    draw_file_explorer args
    
    args.outputs.primitives << {
      x: 1072,
      y: 174,
      text: "[ESCAPE] BACK",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 6,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 1090,
      y: 120,
      text: "[ENTER] NEXT",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 6,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 1032,
      y: 64,
      text: "[HOME] EDIT PATH",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 6,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    if args.state.explorer_action == 0
      args.outputs.primitives << {
        x: 650,
        y: 8.from_top,
        text: "SELECT GAME EXECUTABLE",
        font: "fonts/ubuntu-title.ttf",
        size_enum: 12,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    elsif args.state.explorer_action == 1
      args.outputs.primitives << {
        x: 650,
        y: 8.from_top,
        text: "SELECT EXECUTABLE LAUNCHER",
        font: "fonts/ubuntu-title.ttf",
        size_enum: 12,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
      
      args.outputs.primitives << {
        x: 650,
        y: 148.from_top,
        text: "(Select same game executable if not launched by another executable)",
        size_enum: -1,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    elsif args.state.explorer_action == 2
      args.outputs.primitives << {
        x: 650,
        y: 8.from_top,
        text: "SELECT IMAGE FOR THE GAME",
        font: "fonts/ubuntu-title.ttf",
        size_enum: 12,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    elsif args.state.explorer_action == 3
      args.outputs.primitives << {
        x: 650,
        y: 8.from_top,
        text: "SELECT BACKGROUND IMAGE",
        font: "fonts/ubuntu-title.ttf",
        size_enum: 12,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    end
    
    args.outputs.primitives << {
      x: 650,
      y: 64.from_top,
      w: 500,
      h: 5,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.solid
    
    args.outputs.primitives << {
      x: 650,
      y: 130.from_top,
      w: 500,
      h: 48,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.edit_dir_mode == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.edit_dir_mode == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.border
    
    args.outputs.primitives << {
      x: 655,
      y: 90.from_top,
      text: args.state.edit_dir_mode == 0 ? args.state.last_dir_substr : args.state.input_dir_substr,
      size_enum: 4,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    if args.state.edit_dir_mode == 1
      args.outputs.primitives << {
        x: 655 + args.state.input_dir_substr.length * 13.5,
        y: 120.from_top,
        w: 5,
        h: 32,
        r: args.state.save0.themes[args.state.default_theme_index].text_color.r + 50,
        g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.solid
    end
    
    file_explorer_input args
  end
  
  add_game_input args
end

# Add Game scene input
def add_game_input args
  if args.state.add_game_scene == 0
    if args.inputs.text[0].to_s != ""
      if args.inputs.text[0].to_s == " "
        play_spacebar_sound args
      else
        play_typing_sound args
      end
      
      args.state.game_name_textbox_str << args.inputs.text[0].to_s
    
      if args.state.game_name_textbox_str.length > 23
        args.state.game_name_textbox_substr = substr(args.state.game_name_textbox_str, args.state.game_name_textbox_str.length - 24, args.state.game_name_textbox_str.length - 1)
      else
        args.state.game_name_textbox_substr = args.state.game_name_textbox_str
        args.state.game_name_textbox_index += 1
      end
    end
  
    if args.inputs.keyboard.backspace
      args.state.backspace_timer += 1
      
      if args.state.backspace_timer == 8
        args.state.game_name_textbox_str = args.state.game_name_textbox_str.chop
        
        if !(args.state.game_name_textbox_index - 1 < 0) && args.state.game_name_textbox_str.length < 23
          args.state.game_name_textbox_index -= 1
        end
        
        args.state.backspace_timer = 0
      end
      
      if args.state.game_name_textbox_str.length > 23
        args.state.game_name_textbox_substr = substr(args.state.game_name_textbox_str, args.state.game_name_textbox_str.length - 24, args.state.game_name_textbox_str.length - 1)
      else
        args.state.game_name_textbox_substr = substr(args.state.game_name_textbox_str, 0, args.state.game_name_textbox_str.length - 1)
      end
    end
    
    if !game_exists(args)
      if args.inputs.keyboard.key_down.enter
        play_select_sound args
        args.state.next_game_name = args.state.game_name_textbox_str
        args.state.game_name_textbox_str = ""
        args.state.game_name_textbox_substr = ""
        args.state.game_name_textbox_index = 0
        args.state.game_genres_textbox_str = ""
        args.state.game_genres_textbox_substr = ""
        args.state.game_genres_textbox_index = 0
        args.state.add_game_scene = 1
      end
    end
    
    if args.inputs.keyboard.key_down.escape
      play_back_sound args
      args.state.adding_game = false
      args.state.current_scene = 1
      args.state.current_menu = 0
      args.state.movement_index = 0
      args.state.selection = 0
      args.state.add_game_scene = 0
      args.state.game_name_textbox_str = ""
      args.state.game_name_textbox_substr = ""
      args.state.game_name_textbox_index = 0
    end
  elsif args.state.add_game_scene == 1
    if args.inputs.text[0].to_s != ""
      if args.inputs.text[0].to_s == " "
        play_spacebar_sound args
      else
        play_typing_sound args
      end
      
      args.state.game_genres_textbox_str << args.inputs.text[0].to_s
      if args.state.game_genres_textbox_str.length > 23
        args.state.game_genres_textbox_substr = substr(args.state.game_genres_textbox_str, args.state.game_genres_textbox_str.length - 24, args.state.game_genres_textbox_str.length - 1)
      else
        args.state.game_genres_textbox_substr = args.state.game_genres_textbox_str
        args.state.game_genres_textbox_index += 1
      end
    end
    
    # Backspace: Clear text
    if args.inputs.keyboard.backspace
      args.state.backspace_timer += 1
      
      if args.state.backspace_timer == 8
        args.state.game_genres_textbox_str = args.state.game_genres_textbox_str.chop
        
        if !(args.state.game_genres_textbox_index - 1 < 0) && args.state.game_genres_textbox_str.length < 23
          args.state.game_genres_textbox_index -= 1
        end
        
        args.state.backspace_timer = 0
      end
      
      if args.state.game_genres_textbox_str.length > 23
        args.state.game_genres_textbox_substr = substr(args.state.game_genres_textbox_str, args.state.game_genres_textbox_str.length - 24, args.state.game_genres_textbox_str.length - 1)
      else
        args.state.game_genres_textbox_substr = substr(args.state.game_genres_textbox_str, 0, args.state.game_genres_textbox_str.length - 1)
      end
    end
    
    if args.inputs.keyboard.key_down.enter
      play_select_sound args
      args.state.next_game_genres = args.state.game_genres_textbox_str.split(", ")
      args.state.game_genres_textbox_str = ""
      args.state.game_genres_textbox_substr = ""
      args.state.game_genres_textbox_index = 0
      args.state.add_game_scene = 2
    end
    
    if args.inputs.keyboard.key_down.escape
      play_back_sound args
      args.state.current_scene = 6
      args.state.add_game_scene = 0
      args.state.game_genres_textbox_str = ""
      args.state.game_genres_textbox_substr = ""
      args.state.game_genres_textbox_index = 0
      args.state.game_name_textbox_str = ""
      args.state.game_name_textbox_substr = ""
      args.state.game_name_textbox_index = 0
      args.state.adding_game = true
    end
  elsif args.state.add_game_scene == 2
    if args.inputs.keyboard.key_down.enter
      play_select_sound args
      if args.state.edit_dir_mode == 1
        if (!File.exist?(args.state.input_dir_str) || args.state.input_dir_str.length == 0)
          # Invalid path, Reset things...
          args.state.edit_dir_mode = 0
          args.state.input_dir_str = ""
          args.state.input_dir_substr = ""
          args.state.input_dir_index = 0
        else
          # Path submitted
          if File.directory?(args.state.input_dir_str)
            args.state.edit_dir_mode = 0
            args.state.input_dir_index = 0
            args.state.last_dir = args.state.input_dir_str
            
            if args.state.last_dir.length > 36
              args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
            else
              args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
            end
      
            args.state.input_dir_str = ""
            args.state.input_dir_substr = ""
            args.state.prev_dirs << args.state.last_dir
          end
        end
      else
        if args.state.last_dir.length > 36
          args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
        else
          args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
        end
      end
    end
    
    if args.state.edit_dir_mode == 1
      if args.inputs.keyboard.backspace
        args.state.backspace_timer += 1
      
        if args.state.backspace_timer == 8
          args.state.input_dir_str = args.state.input_dir_str.chop
        
          if !(args.state.input_dir_index - 1 < 0) && args.state.input_dir_str.length < 34
            args.state.input_dir_index -= 1
          end
          
          if args.state.input_dir_str.length > 36
            args.state.input_dir_substr = substr(args.state.input_dir_str, args.state.input_dir_str.length - 34, args.state.input_dir_str.length - 1)
          else
            args.state.input_dir_substr = args.state.input_dir_str
          end
        
          args.state.backspace_timer = 0
        end
      elsif args.inputs.text[0].to_s != ""
        if args.inputs.text[0].to_s == " "
          play_spacebar_sound args
        else
          play_typing_sound args
        end
      
        # That's how textbox handles text
        args.state.input_dir_str << args.inputs.text[0].to_s
    
        if args.state.input_dir_str.length > 36
          args.state.input_dir_substr = substr(args.state.input_dir_str, args.state.input_dir_str.length - 34, args.state.input_dir_str.length - 1)
        else
          args.state.input_dir_substr = args.state.input_dir_str
          args.state.input_dir_index += 1
        end
      end
    end
    
    if args.inputs.keyboard.key_down.escape
      play_back_sound args
      if args.state.explorer_action == 0
        args.state.current_scene = 6
        args.state.add_game_scene = 1
        args.state.last_dir = root_dir()
      
        if args.state.last_dir.length > 36
          args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
        else
          args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
        end
            
        args.state.input_dir_str = ""
        args.state.input_dir_substr = ""
        args.state.input_dir_index = 0
        args.state.game_genres_textbox_str = ""
        args.state.game_genres_textbox_substr = ""
        args.state.game_genres_textbox_index = 0
        args.state.game_name_textbox_str = ""
        args.state.game_name_textbox_substr = ""
        args.state.game_name_textbox_index = 0
        args.state.adding_game = true
      elsif args.state.explorer_action == 1
        args.state.next_game_exeloader_dir = ""
        args.state.next_game_exe_dir = ""
        args.state.last_dir = root_dir()
      
        if args.state.last_dir.length > 36
          args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
        else
          args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
        end
            
        args.state.input_dir_str = ""
        args.state.input_dir_substr = ""
        args.state.input_dir_index = 0
        args.state.explorer_action = 0
        args.state.adding_game = true
      elsif args.state.explorer_action == 2
        args.state.next_game_exeloader_dir = ""
        args.state.next_game_image_dir = ""
        args.state.last_dir = root_dir()
      
        if args.state.last_dir.length > 36
          args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
        else
          args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
        end
            
        args.state.input_dir_str = ""
        args.state.input_dir_substr = ""
        args.state.input_dir_index = 0
        args.state.explorer_action = 1
        args.state.adding_game = false
      elsif args.state.explorer_action == 3
        args.state.current_scene = 4
        args.state.current_menu = 3
        args.state.options_menu_inselect = 0
        args.state.options_menu_selection = 5
        args.state.save3.custom_background_path = ""
        args.state.last_dir = root_dir()
        
        if args.state.last_dir.length > 36
          args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
        else
          args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
        end
        
        args.state.input_dir_str = ""
        args.state.input_dir_substr = ""
        args.state.input_dir_index = 0
        args.state.explorer_action = 1
        args.state.selecting_background = false
      end
    end
  end
end

# Draw GUI used by most menus
def draw_gui args
  # + Add Game rectangle
  args.outputs.primitives << {
    x: (args.state.save1.games.length - args.state.movement_index) * 452 + 54,
    y: 400.from_top,
    w: 400,
    h: 200,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: (args.state.save1.games.length - args.state.movement_index) * 452 + 172,
    y: 195.from_top,
    text: "+",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 128,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: (args.state.selection - args.state.movement_index) * 452 + 28,
    y: 424.from_top,
    w: 452,
    h: 252,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 32,
    y: 280,
    text: (args.state.selection != args.state.save1.games.length) ? args.state.save1.games[args.state.selection].name : "ADD NEW GAME",
    size_enum: 16,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  if args.state.save1.games.length > 0
    if args.state.selection < args.state.save1.games.length
      if args.state.save1.games[args.state.selection].playing != nil
        args.outputs.primitives << {
          x: 32,
          y: 220,
          text: args.state.save1.games[args.state.selection].playing == 1 ? "PLAYING" : "",
          font: "fonts/ubuntu-title.ttf",
          size_enum: 6,
          r: args.state.save1.games[args.state.selection].playing == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
          g: args.state.save1.games[args.state.selection].playing == 1 ? 150 : args.state.save0.themes[args.state.default_theme_index].text_color.g,
          b: args.state.save1.games[args.state.selection].playing == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
          a: 255
        }.label
      end
    end
  end
end

# Draw menus labels
def draw_menu args
  draw_background args
  
  args.outputs.primitives << {
    x: args.state.current_menu * 112,
    y: 100.from_top,
    w: 190,
    h: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.solid
  
  args.state.menu_texts.length.times.map do |i|
    args.outputs.primitives << {
      x: i * 216 + 16,
      y: 16.from_top,
      text: args.state.menu_texts[i],
      font: "fonts/ubuntu-title.ttf",
      size_enum: 22,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
  
  args.outputs.primitives << {
    x: 16,
    y: 64,
    text: "[TAB] SWITCH TAB",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 12,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  if args.state.current_menu <= 2
    args.outputs.primitives << {
      x: args.state.options_menu_inselect == 0 ? 1000 : 955,
      y: 64,
      text: "[ENTER] SELECT",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 16,
      y: 114,
      text: "[LEFT/RIGHT] NAVIGATE",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: 960,
      y: 114,
      text: "[DELETE] REMOVE",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  elsif args.state.current_scene == 3
    args.outputs.primitives << {
      x: 855,
      y: 64,
      text: "[LEFT/RIGHT] NAVIGATE",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  elsif args.state.current_scene == 4
    args.outputs.primitives << {
      x: 855,
      y: 64,
      text: "[LEFT/RIGHT] NAVIGATE",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
    
    args.outputs.primitives << {
      x: args.state.options_menu_inselect == 0 ? 1000 : 955,
      y: 114,
      text: args.state.options_menu_inselect == 0 ? "[ENTER] SELECT" : "[ENTER] DESELECT",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 12,
      r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
end

# Launch game scene: Here we go! ;)
def launch_game args
  draw_background args
  
  args.outputs.primitives << {
    x: 370,
    y: 36.from_top,
    text: "LAUNCH GAME?",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 36,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  # Draw game info
  args.outputs.primitives << {
    x: 64,
    y: 470.from_top,
    w: 500,
    h: 250,
    path: args.state.game_to_launch.image
  }.sprite
  
  args.outputs.primitives << {
    x: 595,
    y: 200.from_top,
    text: args.state.game_to_launch.name,
    font: "fonts/ubuntu-title.ttf",
    size_enum: 34,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 600,
    y: 330.from_top,
    text: "TOTAL TIME PLAYED: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 910,
    y: 338.from_top,
    text: (args.state.game_to_launch.time_played != nil ? secs_to_str(args.state.game_to_launch.time_played) : "NOT PLAYED YET"),
    size_enum: 4,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 600,
    y: 380.from_top,
    text: "LAST TIME PLAYED: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 895,
    y: 388.from_top,
    text: args.state.game_to_launch.last_time_played_str != nil ? args.state.game_to_launch.last_time_played_str : " NOT PLAYED YET",
    size_enum: 4,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 600,
    y: 430.from_top,
    text: "GENRES: ",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 735,
    y: 438.from_top,
    text: combine_genres_arr(args.state.game_to_launch.genres),
    size_enum: 4,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 64,
    y: (720 - (args.state.launch_game_selection * 75 + 25)).from_top,
    w: 1180,
    h: 60,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
  
  if args.state.game_to_launch.playing != nil
    args.outputs.primitives << {
      x: 64,
      y: 240,
      text: args.state.game_to_launch.playing == 1 ? "PLAYING" : "",
      font: "fonts/ubuntu-title.ttf",
      size_enum: 6,
      r: args.state.save1.games[args.state.selection].playing == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
      g: args.state.save1.games[args.state.selection].playing == 1 ? 150 : args.state.save0.themes[args.state.default_theme_index].text_color.g,
      b: args.state.save1.games[args.state.selection].playing == 1 ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
      a: 255
    }.label
  end
  
  args.outputs.primitives << {
    x: 576,
    y: 160,
    text: "PLAY!",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 16,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 576,
    y: 80,
    text: "BACK!",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 16,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.label
  
  launch_game_input args
end

# Launch Game scene input
def launch_game_input args
  if args.inputs.keyboard.key_down.up
    play_select_sound args
    if args.state.launch_game_selection == 1
      args.state.launch_game_selection = 0
    elsif args.state.launch_game_selection == 0
      args.state.launch_game_selection = 1
    end
  elsif args.inputs.keyboard.key_down.down
    play_select_sound args
    if args.state.launch_game_selection == 1
      args.state.launch_game_selection = 0
    elsif args.state.launch_game_selection == 0
      args.state.launch_game_selection = 1
    end
  elsif args.inputs.keyboard.key_down.enter
    if args.state.launch_game_selection == 1
      play_select_sound args
      if $gtk.platform == "Windows"
        $gtk.exec("powershell Unblock-File #{args.state.game_to_launch.exeloaderpath};powershell Unblock-File #{args.state.game_to_launch.exepath};powershell -ExecutionPolicy Bypass Start-Process -FilePath #{args.state.game_to_launch.exeloaderpath} -WorkingDirectory #{dir(args.state.game_to_launch.exeloaderpath)}")
      else
        $gtk.exec("cd ~ && cd #{dir(args.state.game_to_launch.exeloaderpath)} && exec #{filename(args.state.game_to_launch.exeloaderpath)}")
      end
      
      args.state.game_to_launch.last_time_played_str = Time.now.to_s
      args.state.game_to_launch.last_time_played = Time.now.to_i
      
      if args.state.game_to_launch.times_played == nil
        args.state.game_to_launch.times_played = 1
      else
        args.state.game_to_launch.times_played += 1
      end
      
      args.state.game_to_launch.launch_index = args.state.launch_index
      args.state.launch_index += 1
      args.state.processes_count += 1
      
      if args.state.game_to_launch.time_played == nil
        args.state.game_to_launch.time_played = 0
      end
      
      args.state.game_to_launch.playing = 1
      args.state.playing_games << { name: args.state.game_to_launch.name, index: args.state.selection }
      args.state.save4.genres_list.concat(args.state.game_to_launch.genres)
      args.state.playing = 1
      save_data args
    elsif args.state.launch_game_selection == 0
      play_back_sound args
      args.state.current_scene = 1
      args.state.current_menu = 0
      args.state.movement_index = 0
      args.state.selection = 0
      args.state.playing = 0
      args.state.launch_game_selection = 1
      args.state.game_to_launch = nil
    end
  end
end

# File explorer's move to previous directory mechanics
def move_to_previous_dir args
  if args.state.prev_dirs.length > 0
    if $gtk.platform == "Windows"
      args.state.last_dir = args.state.prev_dirs[-1] << "\\"
    else
      args.state.last_dir = args.state.prev_dirs[-1] << "/"
    end
    
    if args.state.last_dir.length > 36
      args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
    else
      args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
    end
    
    args.state.explorer_movement_index = 0
    args.state.prev_dirs.pop
  else
    args.state.prev_dirs << args.state.last_dir
    args.state.last_dir = prev_dir(args.state.last_dir)
  end
end

# File explorer GUI which used to set background and game's image
def draw_file_explorer args
  args.state.explorer_content.length.times.map do |i|    
    args.outputs.primitives << {
      x: 40,
      y: (((i - args.state.explorer_movement_index) * 32 + 64) + 256).from_top,
      w: 32,
      h: 32,
      path: args.state.explorer_content[i].directory == 1 ? "sprites/folder.png" : "sprites/file.png"
    }.sprite
    
    if args.state.explorer_action < 2
      if $gtk.platform == "Windows"
        is_exe = is_executable(args, args.state.explorer_content[i].name)
      else
        is_exe = is_executable(args, args.state.explorer_content[i].name)
      end
       
      args.outputs.primitives << {
        x: 90,
        y: (((i - 1 - args.state.explorer_movement_index) * 32 + 82) + 240).from_top,
        text: args.state.explorer_content[i].name,
        size_enum: 2,
        r: is_exe ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: is_exe ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: is_exe ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    else
      if $gtk.platform == "Windows"
        is_img = is_image(args, args.state.explorer_content[i].name)
      else
        is_img = is_image(args, args.state.explorer_content[i].name)
      end
      
      args.outputs.primitives << {
        x: 90,
        y: (((i - 1 - args.state.explorer_movement_index) * 32 + 82) + 240).from_top,
        text: args.state.explorer_content[i].name,
        size_enum: 2,
        r: is_img ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.r,
        g: is_img ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.g,
        b: is_img ? 0 : args.state.save0.themes[args.state.default_theme_index].text_color.b,
        a: 255
      }.label
    end
  end
  
  args.outputs.primitives << {
    x: 40,
    y: ((args.state.explorer_movement_index + 1 * 64 - args.state.explorer_movement_index) + 256).from_top,
    w: 1000,
    h: 32,
    r: args.state.save0.themes[args.state.default_theme_index].text_color.r,
    g: args.state.save0.themes[args.state.default_theme_index].text_color.g,
    b: args.state.save0.themes[args.state.default_theme_index].text_color.b,
    a: 255
  }.border
end

# Input of File explorer
def file_explorer_input args
  if args.inputs.keyboard.key_down.up
    if args.state.explorer_movement_index - 1 < 0
      args.state.explorer_movement_index = args.state.cd_files.length + args.state.cd_dirs.length - 1
    else
      args.state.explorer_movement_index -= 1
    end
  end
  
  if args.inputs.keyboard.key_down.down
    if args.state.explorer_movement_index + 1 > args.state.cd_files.length + args.state.cd_dirs.length - 1
      args.state.explorer_movement_index = 0
    else
      args.state.explorer_movement_index += 1
    end
  end
  
  if args.inputs.keyboard.key_down.home
    if args.state.edit_dir_mode == 0
      args.state.input_dir_index = 0
      args.state.input_dir_str = ""
      args.state.input_dir_substr = ""
      args.state.edit_dir_mode = 1
    end
  end
  
  if args.state.explorer_action == 3
    if args.inputs.keyboard.key_down.escape
      play_back_sound args
      args.state.current_scene = 4
      args.state.current_menu = 3
      args.state.options_menu_inselect = 0
      args.state.options_menu_selection = 5
      args.state.last_dir = root_dir()
              
      if args.state.last_dir.length > 36
        args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
      else
        args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
      end
            
      args.state.input_dir_index = 0
      args.state.input_dir_str = ""
      args.state.input_dir_substr = ""
      args.state.next_game_exeloader_dir = ""
      args.state.explorer_action = 0
      args.state.add_game_scene = 0
   
      args.state.adding_game = false
      args.state.selecting_background = false
    end
  end
  
  if args.inputs.keyboard.key_down.enter
    play_select_sound args
    if args.state.explorer_content[args.state.explorer_movement_index].directory == 0
      if args.state.explorer_action == 0
        if $gtk.platform == "Windows"
          args.state.next_game_exe_dir = "#{args.state.last_dir}\\#{args.state.explorer_content[args.state.explorer_movement_index].name}"
        else
          args.state.next_game_exe_dir = "#{args.state.last_dir}/#{args.state.explorer_content[args.state.explorer_movement_index].name}"
        end
                
        if is_executable(args, args.state.explorer_content[args.state.explorer_movement_index].name)
          args.state.last_dir = root_dir()
              
          if args.state.last_dir.length > 36
            args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
          else
            args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
          end
            
          args.state.input_dir_index = 0
          args.state.input_dir_str = ""
          args.state.input_dir_substr = ""
          args.state.next_game_exeloader_dir = ""
          args.state.explorer_action = 1
        else
          args.state.next_game_exe_dir = ""
        end       
      elsif args.state.explorer_action == 1
        if $gtk.platform == "Windows"
          args.state.next_game_exeloader_dir = "#{args.state.last_dir}\\#{args.state.explorer_content[args.state.explorer_movement_index].name}"
        else
          args.state.next_game_exe_dir = "#{args.state.last_dir}/#{args.state.explorer_content[args.state.explorer_movement_index].name}"
        end
        
        if is_executable(args, args.state.explorer_content[args.state.explorer_movement_index].name)
          args.state.last_dir = root_dir()
          
          if args.state.last_dir.length > 36
            args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
          else
            args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
          end
            
          args.state.input_dir_index = 0
          args.state.input_dir_str = ""
          args.state.input_dir_substr = ""
          args.state.next_game_image_dir = ""
          args.state.explorer_action = 2
        else
          args.state.next_game_exeloader_dir = ""
        end
      elsif args.state.explorer_action == 2
        if $gtk.platform == "Windows"
          args.state.next_game_image_dir = "#{args.state.last_dir}\\#{args.state.explorer_content[args.state.explorer_movement_index].name}"
        else
          args.state.next_game_image_dir = "#{args.state.last_dir}/#{args.state.explorer_content[args.state.explorer_movement_index].name}"
        end
        
        if is_image(args, args.state.explorer_content[args.state.explorer_movement_index].name)
          if $gtk.platform == "Windows" 
            path = "#{args.state.last_dir}\\#{args.state.explorer_content[args.state.explorer_movement_index].name}"
            $gtk.log path
            $gtk.system("imgcopy.cmd #{path.quote} data/images")
          else
            path = "#{args.state.last_dir}/#{args.state.explorer_content[args.state.explorer_movement_index].name}"
            $gtk.log path
            $gtk.log "cp #{path.quote} data/images"
            $gtk.system("cp #{path.quote} data/images")
          end

          args.state.save1.games << {
            name: args.state.next_game_name,
            exepath: args.state.next_game_exe_dir,
            exeloaderpath: args.state.next_game_exeloader_dir,
            genres: args.state.next_game_genres,
            image: "data/images/#{args.state.explorer_content[args.state.explorer_movement_index].name}",
          }
          
          args.state.last_dir = root_dir()
          if args.state.last_dir.length > 36
            args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
          else
            args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
          end
                
          args.state.input_dir_index = 0
          args.state.input_dir_str = ""
          args.state.input_dir_substr = ""
          args.state.next_game_name = ""
          args.state.next_game_exe_dir = ""
          args.state.next_game_exeloader_dir = ""
          args.state.next_game_genres = ""
          args.state.next_game_image_dir = ""
          args.state.adding_game = false
          args.state.explorer_action = 0
          args.state.add_game_scene = 0
          args.state.edit_dir_mode = 0
          args.state.selection = 0
          args.state.movement_index = 0
          args.state.current_scene = 1
          args.state.current_menu = 0
          
          save_data args
        else
          args.state.next_game_image_dir = ""
        end
      elsif args.state.explorer_action == 3
        if is_image(args, args.state.explorer_content[args.state.explorer_movement_index].name)
          if $gtk.platform == "Windows"
            path = "#{args.state.last_dir}\\#{args.state.explorer_content[args.state.explorer_movement_index].name}"
            $gtk.system("imgcopy.cmd #{path.quote} data/backgrounds")
          else
            path = "#{args.state.last_dir}/#{args.state.explorer_content[args.state.explorer_movement_index].name}"
            $gtk.system("cp #{path.quote} data/backgrounds")
          end
          
          args.state.save3.custom_background_path = "data/backgrounds/#{args.state.explorer_content[args.state.explorer_movement_index].name}"
          args.state.input_dir_index = 0
          args.state.input_dir_str = ""
          args.state.input_dir_substr = ""
          args.state.next_game_name = ""
          args.state.next_game_exe_dir = ""
          args.state.next_game_exeloader_dir = ""
          args.state.next_game_genres = ""
          args.state.next_game_image_dir = ""
          args.state.adding_game = false
          args.state.selecting_background = false
          args.state.explorer_action = 0
          args.state.add_game_scene = 0
          args.state.edit_dir_mode = 0
          args.state.selection = 0
          args.state.movement_index = 0
          args.state.current_scene = 1
          args.state.current_menu = 0
          args.state.custom_background = 1
          
          args.state.last_dir = root_dir()
          
          if args.state.last_dir.length > 36
            args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
          else
            args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
          end
          
          save_data args
        else
          args.state.custom_background = 0
          args.state.save3.custom_background_path = ""
        end
      end
    else
      if (args.state.explorer_content[args.state.explorer_movement_index].name == "..")
        move_to_previous_dir args
      else
        args.state.prev_dirs << args.state.last_dir
        if $gtk.platform == "Windows"
          args.state.last_dir.delete_suffix!("\\")
          args.state.last_dir += "\\#{args.state.cd_dirs[args.state.explorer_movement_index]}"
          args.state.explorer_movement_index = 0
        else
          args.state.last_dir += "/#{args.state.cd_dirs[args.state.explorer_movement_index]}"
          args.state.explorer_movement_index = 0
        end
        
        if args.state.last_dir.length > 36
          args.state.last_dir_substr = substr(args.state.last_dir, args.state.last_dir.length - 34, args.state.last_dir.length - 1)
        else
          args.state.last_dir_substr = substr(args.state.last_dir, 0, args.state.last_dir.length - 1)
        end
      end
    end
  end
  
  if args.inputs.keyboard.key_down.backspace
    if args.state.edit_dir_mode == 0
      move_to_previous_dir args
    end
  end
  
  fetch_dir(args, args.state.last_dir)
end
