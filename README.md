<h1 align="center">Google-Docs Like Clone With Flutter Web and Appwrite</h1>

<p align="center">  
This project is a demo application showing how to create a rich text editing experience, similar to Google Docs, using <a href="https://flutter.dev/">Flutter</a>, <a href="https://appwrite.io/">Appwrite</a>, and <a href="https://pub.dev/packages/flutter_quill">Flutter-Quill</a>. This is meant to serve as a demo on how to use these tools. Please see the video tutorial for a step-by-step walkthrough. Beginner friendly 😎
</br>

### Realtime Changes - Collaboration
Collaborate with other users on the same document in real-time.

<p align="center">
<img alt="Realtime changes demos" src="https://user-images.githubusercontent.com/13705472/162619976-6896a508-10b0-444f-84ac-894ada48e18a.gif" />
</p>

### Create and Open Documents
Easily create and re-open documents. Everything is saved to your Appwrite database.

<p align="center">
<img alt="Create a new document demo" src="https://user-images.githubusercontent.com/13705472/162619991-f6742a46-e1ec-46d8-8701-6922398248ca.gif" />
</p>

### Authentication - Sign-in and Create New Accounts
Easy authentication using Appwrite.

<p align="center">
<img alt="Registration demo" src="https://user-images.githubusercontent.com/13705472/162620014-ee411a9f-9f1c-419a-b846-5bbb876701bd.gif" />
</p>


## Packages
Packages used in this project.

<img alt="built with appwrite logo"  src="https://user-images.githubusercontent.com/13705472/162620390-34dbbcab-b9c2-44b9-966e-adf6d7a63933.svg" align="right" width="32%"/>

### Backend: Appwrite
[Appwrite](https://appwrite.io/) is an open-source alternative to Firebase and makes it possible to easily integrate authentication and add a backend database for your application. Appwrite also makes it possible to add real-time listeners to your database quickly.

> Appwrite sponsored this project and tutorial

### Rich Text Editor: Flutter-Quill
[FlutterQuill](https://pub.dev/packages/flutter_quill) is a rich text editor and a [Quill](https://quilljs.com/docs/formats) component for [Flutter](https://github.com/flutter/flutter). This package makes it easy to sync incremental changes to other editors (real-time changes).

**Honorable Mentions**: [SuperEditor](https://superlist.com/SuperEditor/)

### State Management: Riverpod
[Riverpod](https://riverpod.dev/) is an excellent choice for a state management solution in your Flutter application, and this tutorial demonstrates multiple scenarios where Riverpod truly shines. If you've not used it before, this project may change your mind. The video tutorial highlights numerous excellent features and demos how to structure and organize your providers.

### Routing: Routemaster
[Routemaster](https://pub.dev/packages/routemaster) simplifies the complexity of Flutter's 2.0 Navigator. This project creates two separate route maps:
- Authenticated routes
- Not authenticated routes

Riverpod, and the authentication state from Appwrite, determine which routes to allow.

### Other Packages
[Equatable](https://pub.dev/packages/equatable): A Dart package that helps implement value-based equality without needing to explicitly override `==` and `hashCode`.
- [UUID](https://pub.dev/packages/uuid): Simple, fast generation of [RFC4122](https://www.ietf.org/rfc/rfc4122.txt) UUIDs.
- [Logging](https://pub.dev/packages/logging): Provides APIs for debugging and error logging.

## Tutorial
The project is split into multiple sections to make the tutorial easy to follow.

### Video Tutorial
For a complete step-by-step guide, see: https://youtu.be/0_GJ1w_iG44

### Tutorial Sections
For the most up-to-date code: see the [master branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/master).

The tutorial sections are extracted as dedicated branches on Github, meaning you can easily follow along and always have the latest code before starting new sections.
0 Intro: [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=0s)
1. Base: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/01-base) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=239s)
2. Setup Riverpod: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/02-setup_riverpod) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=308s)
3. Setup Routemaster: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/03-setup_routemaster) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=398s)
4. Appwrite Setup: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/04-appwrite_setup) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=697s)
5. Create Authentication Repository: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/05-auth_repository) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=1039s)
6. Create Auth State Service: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/06-auth_state_service) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=1473s)
7. Create Login and Register Page: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/07-login_and_register_page) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=2099s)
8. Add Logged in Routes: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/08-add_logged_in_routes) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=2702s)
9. Add Document UI and State: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/09-add_document_ui_and_state) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=3118s)
10. Create Documents: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/10-create_documents) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=4067s)
11. Update and Save Documents: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/11-update_and_save_documents) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=4695s)
12. Add Realtime Changes: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/12-realtime_changes) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=5722s)
13. List All Documents: [branch](https://github.com/funwithflutter/google-docs-clone-flutter/tree/13-list_all_documents) and [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=6525s)
14. What's Next?: [video](https://www.youtube.com/watch?v=0_GJ1w_iG44&t=7011s)
