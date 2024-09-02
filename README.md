# StoryText

Interactive cross-platform book application basis that combines elements of a messaging app with branching storylines.

You can use this base to write any story in a group chat messaging interactive format.
Different virtual personas are interacting as they were chatting all together on a group chat.
The reader can interact by answering some predefined multiple choice questions (MCQ) and altering the course of the story.

<img src="./docs/img/chat.png" alt="Example chat" width="250px">

On the writer side of things, everything is defined in the `content.yaml` file.
You can check a fully featured example [content.yaml](./assets/content/content.yaml).

## Features

The StoryText interactive book application currently supports the following features:

- Sending predefined text messages on a chat-like interface
- Multiple personas with profile picture
- Branching storylines with user answered MCQs
- Markdown text messages (hyperlinks, bold, italic, titles, ...)
- Delay for "reading" and "sending" next message (based on text length)
- Fake "is typing" indicator
- "Writer mode" allows to cheat and jump to restart the story at a given message ID (long click on app bar title)
- Persistent storage of current position in the story as well as all explored paths
- Change past choice in previously answered MCQs to explore new paths
- Visual indicator of undiscovered/discovered/current path on MCQs answers
- Send pictures (works offline with assets) along with source link

You can check the "roadmap" for future features: [project board](https://github.com/users/gruvw/projects/4).

## Live Demo

You can check out a live (very basic) example/demo showing off every feature of StoryText here: <https://storytext.gruvw.com/>.

## Usage

To create you own story using this template you should follow the steps below:

- Fork this repository <https://github.com/gruvw/storytext> (click on "Fork" on the GitHub web interface)
- Change the content of the CNAME file located at `./web/CNAME` with you own [custom domain for GitHub pages](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- Change the name of your story by changing the text inside double quotes (`"StoryText"`) in the file `./lib/static/values.dart`
- Change the application icon located at `./assets/images/app_icon.png`
- Write your own story using the YAML file located at `./assets/content/content.yaml` - it is prefiled with a basic example to explain the syntax of the file
- Add personas profile pictures to the directory `./assets/images/personas/` before referencing them in the `content.yaml`
- Add story messages pictures to the directory `./assets/images/story/` before referencing them in the `content.yaml`
- The application will get built and deployed to GitHub pages every time new commits are pushed to the repository

Helpful resources:

- YAML format: <https://yaml.org/spec/1.2.2/>
- Markdown format: <https://www.markdownguide.org/getting-started/>

For more advanced customization or deployment to other platforms, you might need to know more about [Flutter](https://flutter.dev/) and modify the source code directly.

**Note** - You can always get updates with new features from this upstream repository by pressing the "Sync Fork" button on your fork.

## Written with StoryText

You can find below a list of books written using StoryText:

- None yet :)

## Contributions

Feel free to contribute by submitting pull requests, whether to add new features, improve existing functionality, or fix bugs :)

Before opening a new PR, make sure to open an issue to discuss it beforehand (first check if a similar issue does not already exist).
