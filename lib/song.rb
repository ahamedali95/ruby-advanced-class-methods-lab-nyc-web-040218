require "pry"
class Song
  attr_accessor :name, :artist_name

  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    new_song = Song.new
    new_song.save
    new_song
  end

  def self.new_by_name(song_name)
    new_song = Song.new
    new_song.name = song_name
    new_song
  end


  def self.create_by_name(song_name)
    new_song = Song.create
    new_song.name = song_name
    new_song
  end

  def self.find_by_name(song_name)
    self.all.find do |song_obj|
      song_obj.name == song_name
    end
  end

  def self.find_or_create_by_name(song_name)
    if self.find_by_name(song_name) == nil
      self.create_by_name(song_name)
    else
      self.find_by_name(song_name)
    end
  end

  def self.alphabetical
    self.all.sort_by do |song_instance|
      song_instance.name
    end
  end

  def self.parse_artist_name(song_info)
    main_split = song_info.split("-")
    limit = main_split[0].length - 2
    main_split[0][0..limit]
  end

  def self.parse_song_name(song_info)
    main_split = song_info.split("-")
    limit = main_split[0].length - 2
    main_split[1][1..-5]
  end

  def self.new_from_filename(song_info)
    new_song = self.new_by_name(parse_song_name(song_info))
    new_song.artist_name = parse_artist_name(song_info)
    new_song
  end

  def self.create_from_filename(song_info)
    new_song = self.create_by_name(parse_song_name(song_info))
    new_song.artist_name = parse_artist_name(song_info)
    new_song
  end

  def self.destroy_all
    @@all.clear
  end

  private_class_method :parse_artist_name, :parse_song_name
end
