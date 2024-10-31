import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/controller/ui/chat_controller.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/utils/utils.dart';
import 'package:study/helpers/widgets/my_breadcrumb.dart';
import 'package:study/helpers/widgets/my_breadcrumb_item.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_flex.dart';
import 'package:study/helpers/widgets/my_flex_item.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/helpers/widgets/my_text_style.dart';
import 'package:study/images.dart';
import 'package:study/views/layouts/layout.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late ChatController controller;

  @override
  void initState() {
    controller = Get.put(ChatController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Chat",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Client'),
                        MyBreadcrumbItem(name: 'Chat', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(sizes: 'lg-3 ', child: buildChatList()),
                    MyFlexItem(sizes: 'lg-6 ', child: buildChatMessages()),
                    MyFlexItem(sizes: 'lg-3', child: buildChatProfile()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildChatList() {
    return MyContainer(
      borderRadiusAll: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller.searchController,
            onChanged: controller.searchChat,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                LucideIcons.search,
                size: 20,
              ),
              hintText: "People, Groups & Messages...",
              border: const OutlineInputBorder(),
              contentPadding: MySpacing.all(16),
            ),
          ),
          MySpacing.height(20),
          SizedBox(
            height: 580,
            child: ListView.separated(
              primary: true,
              shrinkWrap: true,
              itemCount: controller.filteredChats.length,
              itemBuilder: (context, index) {
                return MyButton(
                  onPressed: () {
                    controller.onChangeChat(controller.filteredChats[index]);
                  },
                  elevation: 0,
                  borderRadiusAll: 8,
                  padding: MySpacing.xy(16, 16),
                  backgroundColor: theme.colorScheme.surface.withAlpha(5),
                  splashColor: theme.colorScheme.onSurface.withAlpha(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyContainer.rounded(
                        height: 40,
                        width: 40,
                        paddingAll: 0,
                        child: Image.asset(
                          controller.filteredChats[index].image,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      MySpacing.width(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText.labelLarge(
                              controller.filteredChats[index].firstName,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 200,
                              child: MyText.bodySmall(
                                controller.filteredChats[index].messages
                                        .lastOrNull?.message ??
                                    "No new Messages",
                                muted: true,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: 400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          if (controller
                                  .filteredChats[index].messages.lastOrNull !=
                              null)
                            MyText.bodySmall(
                              '${Utils.getTimeStringFromDateTime(
                                controller.filteredChats[index].messages
                                    .lastOrNull!.sendAt,
                                showSecond: false,
                              )}',
                              muted: true,
                              fontWeight: 600,
                            ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return MySpacing.height(20);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChatMessages() {
    return MyContainer(
      borderRadiusAll: 8,
      child: controller.selectedChat != null
          ? Column(
              children: [
                SizedBox(
                  height: 550,
                  child: ListView.separated(
                    controller: controller.scrollController,
                    itemCount: (controller.selectedChat?.messages ?? []).length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final message =
                          (controller.selectedChat?.messages ?? [])[index];
                      final isSent = message.fromMe == true;
                      final theme = isSent
                          ? contentTheme.primary
                          : contentTheme.secondary;

                      return Row(
                        mainAxisAlignment: isSent
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isSent)
                            Column(
                              children: [
                                MyContainer.rounded(
                                  height: 32,
                                  width: 32,
                                  paddingAll: 0,
                                  child: Image.asset(
                                    controller.selectedChat!.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                MySpacing.height(4),
                                MyText.bodySmall(
                                  '${Utils.getTimeStringFromDateTime(
                                    message.sendAt,
                                    showSecond: false,
                                  )}',
                                  fontSize: 8,
                                  muted: true,
                                  fontWeight: 600,
                                ),
                              ],
                            ),
                          MySpacing.width(12),
                          Expanded(
                            child: Wrap(
                              alignment: isSent
                                  ? WrapAlignment.end
                                  : WrapAlignment.start,
                              children: [
                                MyContainer(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                    left: isSent
                                        ? MediaQuery.of(context).size.width *
                                            0.20
                                        : 0,
                                    right: isSent
                                        ? 0
                                        : MediaQuery.of(context).size.width *
                                            0.20,
                                  ),
                                  color: theme.withAlpha(30),
                                  borderRadiusAll: 8,
                                  child: MyText.bodyMedium(
                                    message.message,
                                    fontWeight: 600,
                                    color: isSent
                                        ? contentTheme.primary
                                        : contentTheme.secondary,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MySpacing.width(12),
                          if (controller.selectedChat != null && isSent)
                            Column(
                              children: [
                                MyContainer.rounded(
                                  height: 32,
                                  width: 32,
                                  paddingAll: 0,
                                  child: Image.asset(
                                    Images.avatars[6],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                MySpacing.height(4),
                                MyText.bodySmall(
                                  '${Utils.getTimeStringFromDateTime(
                                    message.sendAt,
                                    showSecond: false,
                                  )}',
                                  fontSize: 8,
                                  muted: true,
                                  fontWeight: 600,
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: MySpacing.xy(12, 12),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MyContainer(
                      color: contentTheme.primary.withAlpha(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.messageController,
                              autocorrect: false,
                              style: MyTextStyle.bodySmall(),
                              decoration: InputDecoration(
                                hintText: "Type message here",
                                hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                contentPadding: MySpacing.xy(16, 16),
                                isCollapsed: true,
                              ),
                            ),
                          ),
                          MySpacing.width(16),
                          InkWell(
                            onTap: () {
                              controller.sendMessage();
                            },
                            child: const Icon(
                              LucideIcons.send,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(
              height: 650,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MySpacing.height(12),
                    MyText.titleLarge(
                      "Chat isn't selected \nPlease Select a chat",
                      fontWeight: 600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildChatProfile() {
    Widget buildContactOptions(IconData icon) {
      return MyContainer.rounded(
        paddingAll: 8,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: contentTheme.secondary.withAlpha(40),
        child: Icon(
          icon,
          size: 16,
          color: contentTheme.secondary,
        ),
      );
    }

    Widget buildProfileDetails(String title, String detail) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText.bodyLarge(title, fontWeight: 600, xMuted: true),
          MyText.bodyLarge(detail, fontWeight: 600)
        ],
      );
    }

    return MyContainer(
      borderRadiusAll: 8,
      child: SizedBox(
        height: 650,
        child: controller.selectedChat != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.selectedChat != null)
                    Center(
                      child: MyContainer.rounded(
                        paddingAll: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 150,
                        child: Image.asset(
                          controller.selectedChat!.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (controller.selectedChat != null)
                    Center(
                      child: MyText.bodyLarge(
                        controller.selectedChat!.firstName,
                        fontSize: 20,
                        fontWeight: 600,
                      ),
                    ),
                  Center(
                    child: Wrap(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      runSpacing: 12,
                      spacing: 12,
                      children: [
                        buildContactOptions(LucideIcons.phoneCall),
                        buildContactOptions(LucideIcons.mail),
                        buildContactOptions(LucideIcons.video),
                        buildContactOptions(LucideIcons.messageSquare),
                      ],
                    ),
                  ),
                  if (controller.selectedChat != null)
                    buildProfileDetails(
                        "Email", controller.selectedChat!.email),
                  if (controller.selectedChat != null)
                    buildProfileDetails(
                        "Phone", "+91 ${controller.selectedChat!.phoneNumber}"),
                  buildProfileDetails("Address", "Los United State"),
                  buildProfileDetails("Plan", "\$ 250"),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MySpacing.height(12),
                    MyText.titleLarge(
                      "Chat isn't selected \nPlease Select a chat",
                      fontWeight: 600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
