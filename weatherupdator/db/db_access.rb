require 'mysql2'
require 'time'

class DBAccess
  def initialize
    user_name = ENV['DB_USERNAME']
    password = ENV['DB_PASSWORD']
    host_name = ENV['DB_HOSTNAME']
    database = ENV['DATABASE_NAME']

    @client = Mysql2::Client.new(host: host_name, username: user_name, password: password)
    query = 'use ' + database
    execute_query(query)
  end

  def execute_query(query)
    return @client.query(query)
  end

  def get_last_insert_id()
    @client.query('select last_insert_id();')
    return @client.last_id
  end

  def insert_weathermap_location(city_id, latitude, longitude, city_name, city_name_ja)
    current_datetime = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    statement = @client.prepare('INSERT INTO weathermap_locations (city_id, latitude, longitude, city_name, created_at, updated_at, city_name_ja) VALUES(?, ?, ?, ?, ?, ?, ?)')
    statement.execute(city_id, latitude, longitude, city_name, current_datetime, current_datetime, city_name_ja)
  end

  def update_weathermap_location(city_id, latitude, longitude, city_name, city_name_ja)
    current_datetime = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    statement = @client.prepare('UPDATE weathermap_locations SET latitude=?, longitude=?, city_name=?, city_name_ja=?, updated_at=? WHERE city_id=?')
    statement.execute(latitude, longitude, city_name, city_name_ja, current_datetime, city_id);
  end

  def insert_weather_group(weather_group_id, weather_icon, weather_main, weather_description)
    current_datetime = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    statement = @client.prepare('INSERT INTO weather_groups (weather_group_id, weather_icon, weather_main, weather_description, created_at, updated_at) VALUES(?, ?, ?, ?, ?, ?)')
    statement.execute(weather_group_id, weather_icon, weather_main, weather_description, current_datetime, current_datetime)
  end

  def insert_current_weather_data(weathermap_location_index, weather_group_index, temperature, pressure,
                                 humidity, temperature_min, temperature_max, wind_speed, wind_degree, cloudiness, rain_1h, rain_3h,
                                 snow_1h, snow_3h, sunrise, sunset, country_code)
    current_datetime = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    statement = @client.prepare('INSERT INTO current_weather_datas (acquired_datetime, weathermap_location_id, weather_group_id, temperature, pressure,
      humidity, temperature_min, temperature_max, wind_speed, wind_degree, cloudiness, rain_1h, rain_3h,
      snow_1h, snow_3h, sunrise, sunset, country_code, created_at, updated_at) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
    statement.execute(current_datetime, weathermap_location_index, weather_group_index, temperature, pressure,
      humidity, temperature_min, temperature_max, wind_speed, wind_degree, cloudiness, rain_1h, rain_3h,
      snow_1h, snow_3h, sunrise, sunset, country_code, current_datetime, current_datetime)
  end

  def delete_current_weather_data_by_weathermap_location_id(weathermap_location_id)
    statement = @client.prepare('DELETE FROM current_weather_datas where weathermap_location_id = ?')
    statement.execute(weathermap_location_id)
  end
end
