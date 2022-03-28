import 'package:flutter/material.dart';

const _menuTextStyle = TextStyle(fontSize: 20);

class MenuBar extends StatelessWidget {
  const MenuBar({
    Key? key,
    this.leading = const [],
    this.trailing = const [],
    this.newDocumentPressed,
    this.openDocumentsPressed,
    this.signOutPressed,
    this.membersPressed,
    this.inviteMembersPressed,
    this.copyPressed,
    this.cutPressed,
    this.redoPressed,
    this.undoPressed,
  }) : super(key: key);

  final List<Widget> leading;
  final List<Widget> trailing;

  final VoidCallback? newDocumentPressed;
  final VoidCallback? openDocumentsPressed;
  final VoidCallback? signOutPressed;
  final VoidCallback? membersPressed;
  final VoidCallback? inviteMembersPressed;

  final VoidCallback? copyPressed;
  final VoidCallback? cutPressed;
  final VoidCallback? redoPressed;
  final VoidCallback? undoPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ...leading,
                const Spacer(),
                ...trailing,
              ],
            ),
            Row(
              children: [
                _FileMenuButton(
                  newDocumentPressed: newDocumentPressed,
                  openDocumentsPressed: openDocumentsPressed,
                  signOutPressed: signOutPressed,
                  membersPressed: membersPressed,
                  inviteMembersPressed: inviteMembersPressed,
                ),
                _EditMenuButton(
                  copyPressed: copyPressed,
                  cutPressed: cutPressed,
                  redoPressed: redoPressed,
                  undoPressed: undoPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FileMenuButton extends StatelessWidget {
  const _FileMenuButton({
    Key? key,
    this.newDocumentPressed,
    this.openDocumentsPressed,
    this.signOutPressed,
    this.membersPressed,
    this.inviteMembersPressed,
  }) : super(key: key);

  final VoidCallback? newDocumentPressed;
  final VoidCallback? openDocumentsPressed;
  final VoidCallback? signOutPressed;
  final VoidCallback? membersPressed;
  final VoidCallback? inviteMembersPressed;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      offset: const Offset(0, 40),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          child: const PopUpMenuTile(
            isActive: true,
            title: 'New Document',
          ),
          onTap: () {
            newDocumentPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          child: const PopUpMenuTile(
            isActive: true,
            title: 'Open',
          ),
          onTap: () {
            openDocumentsPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          child: const PopUpMenuTile(
            isActive: true,
            icon: Icons.logout_rounded,
            title: 'Sign out',
          ),
          onTap: () {
            signOutPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          child: const PopUpMenuTile(
            icon: Icons.group,
            title: 'Members',
          ),
          onTap: () {
            membersPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          child: const PopUpMenuTile(
            icon: Icons.person_add,
            title: 'Invite members',
          ),
          onTap: () {
            inviteMembersPressed?.call();
          },
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'File',
          style: _menuTextStyle,
        ),
      ),
    );
  }
}

class _EditMenuButton extends StatelessWidget {
  const _EditMenuButton({
    Key? key,
    this.undoPressed,
    this.redoPressed,
    this.cutPressed,
    this.copyPressed,
    this.pastePressed,
  }) : super(key: key);

  final VoidCallback? undoPressed;
  final VoidCallback? redoPressed;
  final VoidCallback? cutPressed;
  final VoidCallback? copyPressed;
  final VoidCallback? pastePressed;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      offset: const Offset(0, 40),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: const PopUpMenuTile(
            isActive: true,
            icon: Icons.undo,
            title: 'Undo',
          ),
          onTap: () {
            undoPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          value: 1,
          child: const PopUpMenuTile(
            isActive: true,
            icon: Icons.redo,
            title: 'Redo',
          ),
          onTap: () {
            redoPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          value: 2,
          child: const PopUpMenuTile(
            icon: Icons.cut,
            title: 'Cut',
          ),
          onTap: () {
            cutPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          value: 3,
          child: const PopUpMenuTile(
            icon: Icons.copy,
            title: 'Copy',
          ),
          onTap: () {
            copyPressed?.call();
          },
        ),
        PopupMenuItem<int>(
          value: 3,
          child: const PopUpMenuTile(
            icon: Icons.paste,
            title: 'Paste',
          ),
          onTap: () {
            pastePressed?.call();
          },
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Edit', style: _menuTextStyle),
      ),
    );
  }
}

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile(
      {Key? key, required this.title, this.icon, this.isActive = false})
      : super(key: key);
  final IconData? icon;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(icon),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
        ),
      ],
    );
  }
}
