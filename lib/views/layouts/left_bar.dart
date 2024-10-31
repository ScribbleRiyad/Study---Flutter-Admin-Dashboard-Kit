import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:study/helpers/services/url_service.dart';
import 'package:study/helpers/theme/app_style.dart';
import 'package:study/helpers/theme/theme_customizer.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/utils/my_shadow.dart';
import 'package:study/helpers/widgets/my_button.dart';
import 'package:study/helpers/widgets/my_card.dart';
import 'package:study/helpers/widgets/my_container.dart';
import 'package:study/helpers/widgets/my_spacing.dart';
import 'package:study/helpers/extensions/string.dart';
import 'package:study/helpers/widgets/my_text.dart';
import 'package:study/images.dart';
import 'package:study/widgets/custom_pop_menu.dart';

typedef LeftBarMenuFunction = void Function(String key);

class LeftBarObserver {
  static Map<String, LeftBarMenuFunction> observers = {};

  static attachListener(String key, LeftBarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;

  const LeftBar({super.key, this.isCondensed = false});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;

  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return MyCard(
      paddingAll: 0,
      shadow: MyShadow(position: MyShadowPosition.centerRight, elevation: 0.2),
      child: AnimatedContainer(
        color: leftBarTheme.background,
        width: isCondensed ? 70 : 260,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Get.toNamed('/client/home');
                      },
                      child: Image.asset(Images.appLogo,
                          height: widget.isCondensed ? 32 : 44)),
                  if (!widget.isCondensed)
                    Flexible(
                      fit: FlexFit.loose,
                      child: MySpacing.width(16),
                    ),
                  if (!widget.isCondensed)
                    Flexible(
                      fit: FlexFit.loose,
                      child: MyText.labelLarge(
                        "Study",
                        style: GoogleFonts.raleway(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: contentTheme.primary,
                          letterSpacing: 1,
                        ),
                        maxLines: 1,
                      ),
                    )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: PageScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelWidget("Client App"),
                  NavigationItem(
                    iconData: LucideIcons.home,
                    title: "Home",
                    isCondensed: isCondensed,
                    route: '/client/home',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.bookOpen,
                    title: "Courses",
                    isCondensed: isCondensed,
                    route: '/client/courses',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.baggageClaim,
                    title: "Cart",
                    isCondensed: isCondensed,
                    route: '/client/cart',
                  ),
                  NavigationItem(
                    iconData: Icons.subscriptions_outlined,
                    title: "Subscription",
                    isCondensed: isCondensed,
                    route: '/client/subscription',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.messagesSquare,
                    title: "Chat",
                    isCondensed: isCondensed,
                    route: '/client/chat',
                  ),
                  labelWidget("Admin Panel"),
                  NavigationItem(
                    iconData: LucideIcons.layoutDashboard,
                    title: "Dashboard",
                    isCondensed: isCondensed,
                    route: '/dashboard',
                  ),
                  NavigationItem(
                    iconData: Icons.space_dashboard_outlined,
                    title: "Teacher Dashboard",
                    isCondensed: isCondensed,
                    route: '/teacher_dashboard',
                  ),
                  MenuWidget(
                    iconData: Icons.subscriptions_outlined,
                    isCondensed: isCondensed,
                    title: "Subscription",
                    children: [
                      MenuItem(
                        title: "List",
                        isCondensed: isCondensed,
                        route: '/admin/subscription/list',
                        iconData: LucideIcons.scrollText,
                      ),
                      MenuItem(
                        title: "Detail",
                        isCondensed: isCondensed,
                        route: '/admin/subscription/detail',
                        iconData: LucideIcons.listOrdered,
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.graduationCap,
                    isCondensed: isCondensed,
                    title: "Students",
                    children: [
                      MenuItem(
                        title: "List",
                        isCondensed: isCondensed,
                        route: '/admin/students/list',
                      ),
                      MenuItem(
                        title: "Detail",
                        isCondensed: isCondensed,
                        route: '/admin/students/detail',
                      ),
                      MenuItem(
                        title: "Add",
                        isCondensed: isCondensed,
                        route: '/admin/students/add',
                      ),
                      MenuItem(
                        title: "Edit",
                        isCondensed: isCondensed,
                        route: '/admin/students/edit',
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.users,
                    isCondensed: isCondensed,
                    title: "Teachers",
                    children: [
                      MenuItem(
                        title: "List",
                        isCondensed: isCondensed,
                        route: '/admin/teacher/list',
                      ),
                      MenuItem(
                        title: "Detail",
                        isCondensed: isCondensed,
                        route: '/admin/teacher/detail',
                      ),
                      MenuItem(
                        title: "Add",
                        isCondensed: isCondensed,
                        route: '/admin/teacher/add',
                      ),
                      MenuItem(
                        title: "Edit",
                        isCondensed: isCondensed,
                        route: '/admin/teacher/edit',
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.building,
                    isCondensed: isCondensed,
                    title: "Organizations",
                    children: [
                      MenuItem(
                        title: "List",
                        isCondensed: isCondensed,
                        route: '/admin/organization/list',
                      ),
                      MenuItem(
                        title: "Add",
                        isCondensed: isCondensed,
                        route: '/admin/organization/add',
                      ),
                      MenuItem(
                        title: "Edit",
                        isCondensed: isCondensed,
                        route: '/admin/organization/edit',
                      ),
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.bookOpen,
                    isCondensed: isCondensed,
                    title: "Courses",
                    children: [
                      MenuItem(
                        title: "List",
                        isCondensed: isCondensed,
                        route: '/admin/Courses/list',
                      ),
                      MenuItem(
                        title: "Detail",
                        isCondensed: isCondensed,
                        route: '/admin/Courses/detail',
                      ),
                      MenuItem(
                        title: "Add",
                        isCondensed: isCondensed,
                        route: '/admin/Courses/add',
                      ),
                      MenuItem(
                        title: "Edit",
                        isCondensed: isCondensed,
                        route: '/admin/Courses/edit',
                      ),
                    ],
                  ),
                  NavigationItem(
                    iconData: LucideIcons.wallet2,
                    title: "Wallet",
                    isCondensed: isCondensed,
                    route: '/admin/wallet',
                  ),
                  NavigationItem(
                    iconData: LucideIcons.settings,
                    title: "Setting",
                    isCondensed: isCondensed,
                    route: '/admin/setting',
                  ),
                  MySpacing.height(16),
                  if (!isCondensed)
                    Center(
                      child: MyButton(
                        borderRadiusAll: AppStyle.buttonRadius.small,
                        elevation: 0,
                        padding: MySpacing.xy(12, 16),
                        onPressed: () {
                          UrlService.goToPurchase();
                        },
                        backgroundColor: contentTheme.primary,
                        child: MyText.labelMedium(
                          'purchase_now'.tr(),
                          color: contentTheme.onPrimary,
                        ),
                      ),
                    ),
                  MySpacing.height(16),
                  if (!isCondensed)
                    InkWell(
                      onTap: () {
                        UrlService.goToPagger();
                      },
                      child: Padding(
                          padding: MySpacing.x(16),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8), // color: contentTheme.primary.withAlpha(40),
                                gradient:
                                LinearGradient(colors: const [Colors.deepPurple, Colors.lightBlue], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white.withAlpha(32),
                                  ),
                                  child: Icon(LucideIcons.layoutDashboard, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                MyText.bodyLarge(
                                  "Ready to use page for any Flutter Project",
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                  ),
                                  child: MyText.bodyMedium(
                                    "Free Download",
                                    color: Colors.black,
                                    fontWeight: 600,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  if (isCondensed)
                    InkWell(
                      onTap: () {
                        UrlService.goToPagger();
                      },
                      child: Padding(
                          padding: MySpacing.x(16),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4), // color: contentTheme.primary.withAlpha(40),
                                gradient:
                                LinearGradient(colors: const [Colors.deepPurple, Colors.lightBlue], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                            child: Icon(
                              LucideIcons.download,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                    ),
                  MySpacing.height(32),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? MySpacing.empty()
        : Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(
              label.toUpperCase(),
              color: leftBarTheme.labelColor,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.clip,
              fontWeight: 700,
            ),
          );
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;

  const MenuWidget(
      {super.key,
      required this.iconData,
      required this.title,
      this.isCondensed = false,
      this.active = false,
      this.children = const []});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeIn)));
    LeftBarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      // onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    // popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (hide) => hideFn = hide,
        onChange: (_) {
          // popupShowing = _;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive)
                    ? leftBarTheme.activeItemColor
                    : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer.bordered(
          paddingAll: 8,
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
                tilePadding: MySpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (value) {
                  LeftBarObserver.notifyAll(widget.title);
                  onChangeExpansion(value);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    LucideIcons.chevronDown,
                    size: 18,
                    color: leftBarTheme.onBackground,
                  ),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: MySpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.iconData,
                      size: 20,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                    MySpacing.width(18),
                    Expanded(
                      child: MyText.labelLarge(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        color: isHover || isActive
                            ? leftBarTheme.activeItemColor
                            : leftBarTheme.onBackground,
                      ),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.transparent,
                children: widget.children),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: MySpacing.xy(18, 7),
          child: MyText.bodySmall(
            "${widget.isCondensed ? "" : "- "}  ${widget.title}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontSize: 12.5,
            color: isActive || isHover
                ? leftBarTheme.activeItemColor
                : leftBarTheme.onBackground,
            fontWeight: isActive || isHover ? 600 : 500,
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem(
      {super.key,
      this.iconData,
      required this.title,
      this.isCondensed = false,
      this.route});

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(16, 0, 16, 8),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          padding: MySpacing.xy(8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(
                    widget.iconData,
                    color: (isHover || isActive)
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                    size: 20,
                  ),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: MySpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
