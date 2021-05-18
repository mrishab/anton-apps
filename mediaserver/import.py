import requests
import os

BASE_URL = 'https://radarr.cloudville.me'
HEADERS = {
    'X-Api-Key': os.environ.get('RADAR_API_KEY')
}

movie_names = [

]

def find_movie(movie_name):
    results = requests.get(BASE_URL + '/api/v3/movie/lookup?term={}'.format(movie_name), headers=HEADERS).json()
    if len(results) <= 0:
        return
    return results[0]

def add_movie(movie):
    movie["qualityProfileId"] = 1
    movie["monitored"] = True
    movie["minimumAvailability"] = "announced"
    movie["addOptions"] = {
        "searchForMovie": True
    }
    movie["rootFolderPath"] = "/movies"
    sc = requests.post(BASE_URL + '/api/v3/movie', json=movie, headers=HEADERS).status_code
    print ('INFO: Status Code = {}'.format(sc))
    return sc == 201

def create_movie_record(movie_name):
    movie = find_movie(movie_name)
    if movie is None:
        print("INFO: No results found for movie: '{}'.".format(movie_name))
        return
    added = add_movie(movie)
    if not added:
        print ('ERROR: Failed to add the movie: "{}"'.format(movie['title']))
        return
    print ("Movie added successfully: '{}'".format(movie_name))
    return movie['title']
    
    

def import_movie(movie_name, official_movie_name):
    file_path = '/downloads/completed/Media/Movies/Bollywood/{}'.format(movie_name)


def import_all():
    for movie_name in movie_names:
        official_movie_name = create_movie_record(movie_name)

if __name__ == '__main__':
    import_all()
