# note_app

Code challenge for CoderPush

## Features

* I can see an empty state when there are no notes
* I can create a new note
* I can see all my notes on a list
* I can open my past notes and edit them
* My text changes are autosaved without me having to click Submit or Save
* My changes are sync'ed to the cloud so that notes are updated real time
* I can create and log in to my account to manage notes belong to me only

#### Setting up

Flutter version: `3.13.3`

##### Third party libs used:

* Bloc - Cubit: `flutter_bloc: ^8.1.3`
* Routing: `auto_route: ^7.8.4 - auto_route_generator: ^7.3.2`
* Dependencies injection: `injectable: ^2.3.1 - get_it: ^7.6.4`
* Quill editor: `flutter_quill: ^7.4.9`
* Firebase: `firebase_auth: ^4.10.1 - firebase_core: ^2.17.0 - firebase_database: ^10.2.7`

##### Important: run build_runner to generate codes before running

## Screens


| Sign-in screen                                                                                                    | Sign-up screen                                                                                                    |
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| <img src="https://github.com/KhangHo096/note_app/assets/69070874/4604d3d5-5ea2-4c99-b238-b94ae9ad91ea" width=30%> | <img src="https://github.com/KhangHo096/note_app/assets/69070874/1a04ee9c-697d-4835-b0bd-67eacc32cd22" width=30%> |



[//]: # (Sign-in screen)

[//]: # ()
[//]: # (<img src="https://github.com/KhangHo096/note_app/assets/69070874/21225acd-812f-428c-9899-a389cb32d8aa" width=30%>)

[//]: # ()
[//]: # (Sign-up screen)

[//]: # ()
[//]: # (<img src="https://github.com/KhangHo096/note_app/assets/69070874/1a04ee9c-697d-4835-b0bd-67eacc32cd22" width=30%>)

Note list screen - empty

<img src="https://github.com/KhangHo096/note_app/assets/69070874/602e9019-fb41-42d1-bd5a-e54c4b4cba2e" width=30%>

Note list screen - has notes

<img src="https://github.com/KhangHo096/note_app/assets/69070874/273c2de8-28c5-4e1a-afe4-fd85ca94576a" width=30%>

Editing/Add note screen