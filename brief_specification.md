# SCREENS OVERVIEW
1. Home
2. Map with pins (spots)
3. List of locations
4. Spot details
5. Add spot form
6. More (contact, help)
7. Search and filter spots
8. Image gallery

## 1. HOME
- map with user location and spots near and list of those spots (press a button to get user location and get spots near),
    we can put some placeholders here to show what it'll look like when user allows access for the location
- recently added spots and reviews
- spots counter (?)

## 2. MAP WITH PINS 
- map with location pins
- pins transform into clusters when there are a lot of spots in one place
- search bar
- my location button
- user taps on a pin -> new page is opened (spot details)

## 3. LIST OF LOCATIONS
- name, equipment, distance
- show on map feature
- search bar
- filters

## 4. SPOT DETAILS
- name, address/coordinates
- map (here or on another screen?)
- equipment
- images
- description
- reviews (?)

## 5. NEW SPOT FORM - 3 PAGES
### NEW SPOT FORM 1
- input for spot details:
    - name
    - size (dropdown)
    - surface (dropdown)
    - coordinates - raw latitude and longitude inputs with map preview and "select on the map" button. When user clicks the button, another screen appears - a map where user can select a direct spot. Maybe inital zoom should be adjusted, and default location should be user's location? Maybe a dialog to ask if the user wants it?
    - address:
        - city
        - house number - optional
        - street - optional
    - description
### NEW SPOT FORM 2
- equipment - list of selectable items

### NEW SPOT FORM 3
- images - at least one required, possibility to select main image

## 6. MORE
- basic contact and legal information
- faq

## 7. SEARCH AND FILTER SPOTS
- search bar (search based on name and location)
- categories and equipment (checkboxes)
- location (based on distance from user location)

## 8. IMAGE GALLERY
- images of workout spot
- zoom

# BOTTOM BAR TABS
- home
- map
- add spot form
- contact/help

# QUESTIONS
1. Do locations added by user need to be approved? Maybe Google Sign In for verification?

# MODELS
1. Workout Spot

## 1. WORKOUT SPOT
- name
- address
- coordinates (lat, lng)
- description
- images
- equipment
- surface
- uploader reference (?)
