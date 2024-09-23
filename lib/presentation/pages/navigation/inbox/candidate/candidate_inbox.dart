import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/app.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/dummy_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/inbox/conversation_item.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/inbox/inbox_conversations.dart';

import '../../../../../core/resources/asset_constants.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../widgets/appBar/inbox_appbar.dart';
import '../../../../widgets/inbox/inbox_segment.dart';
import '../../../../widgets/slidable/slidable_item.dart';
import '../../../../widgets/utils/keyboard.dart';
import 'chatbox_page.dart';

class CandidateInboxPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  const CandidateInboxPage({super.key, required this.scaffoldState});

  @override
  State<CandidateInboxPage> createState() => _CandidateInboxPageState();
}

class _CandidateInboxPageState extends State<CandidateInboxPage> {
  CustomSegmentedController<String> segmentController =
      CustomSegmentedController();
  FocusNode focusNode = FocusNode();
  final PageController pageController = PageController();
  final _pages = [
    TranslationKeys.all,
    TranslationKeys.superMessages,
    TranslationKeys.favorites
  ];
  String searchQuery = "";
  @override
  void initState() {
    super.initState();
  //  userInbox.add(const StartInboxEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.shade00,
      appBar: InboxAppBar(
        focusNode: focusNode,
        scaffoldState: widget.scaffoldState,
        onSearch: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
      body: Column(
        children: [
          InboxSegment(
            options: _pages,
            onChangeSegment: (value) {
              final index = _pages.indexWhere((element) => element == value);
              pageController.animateToPage(index,
                  duration: const Duration(microseconds: 300),
                  curve: Curves.easeInOut);

              focusNode.unfocus();
              FocusScope.of(context).unfocus();
              Keyboard.hide();
            },
            controller: segmentController,
          ),
         Expanded(
             child: PageView.builder(
                 scrollDirection: Axis.horizontal,
                 itemCount: _pages.length,
                 onPageChanged: (pages){
                   final item = _pages[pages] ;
                   segmentController.value = item ;
                   focusNode.unfocus() ;
                   FocusScope.of(context).unfocus() ;
                   Keyboard.hide() ;
                 },
                 itemBuilder: (context , index){
                     return InboxConversationsList(
                         conversationsList: ["Srijan" , "Sreeja", "Arijit"],
                         itemBuilder: (messageChannel){
                            return ConversationModel(
                                id: "id",
                                profile: "https://w7.pngwing.com/pngs/481/1016/png-transparent-shell-logo-royal-dutch-shell-logo-company-business-shell-miscellaneous-company-service-thumbnail.png",
                                superUser: false ,
                                online: true ,
                                seen: false,
                                favorite: true ,
                                title: "App Developer",
                                message: "Hye Your profile Looks Nice",
                                timestamp: "4:21 PM",
                                state: ConversationState.read,
                                actionItems: [
                                  SlidableActionItem(
                                    icon: AssetConstant.messageXIcon,
                                    title: TranslationKeys.unMatch,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0)),
                                    background: ColorConstant.destructive500,
                                    foreground: ColorConstant.shade00,
                                  ),
                                  SlidableActionItem(
                                    icon: AssetConstant.dottedVerticalIcon,
                                    title: TranslationKeys.more,
                                    background: ColorConstant.primary500,
                                    foreground: ColorConstant.shade00,
                                  ),
                                ]) ;
                         },
                         onTap: (chanel){
                           globalNavKey.currentState!.push(MaterialPageRoute(builder: (_)=> ChatBoxPage()));

                         }, onSliderTap: (_ , __){}) ;
                 }))
         /* Expanded(
            child: UserInboxBuilderWidget(
              builder: (context, state) => PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: _pages.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (page) {
                  final item = _pages[page];
                  segmentController.value = item;
                  focusNode.unfocus();
                  FocusScope.of(context).unfocus();
                  Keyboard.hide();
                },
                itemBuilder: (context, index) => InboxConversationsList(
                  conversationsList: state.channels
                      .where((e) => !e.isArchived && e.isUnmatched.isEmpty)
                      .where((e) => !e.isPendingSuperMessageFromYou)
                      .where((e) {
                        if (_pages[index] == currentLocalizations.all) {
                          return true;
                        } else if (_pages[index] ==
                            currentLocalizations.superMessages) {
                          return e.category == MessageChannelTypes.superMessage;
                        } else {
                          return e.favoriteByUsers
                              .contains(authV2Service.getUserID());
                        }
                      })
                      .where((element) => element
                          .companyUsers.items.first.companyName
                          .contains(searchQuery))
                      .sortedBy((channel) => channel.updatedAt)
                      .toList()
                      .reversed
                      .toList(),
                  onTap: (channel) {
                    globalNavKey.currentState!
                        .push(
                      MaterialPageRoute(
                        builder: (_) => ChatboxPage(
                          channel: channel,
                        ),
                      ),
                    )
                        .then((value) {
                      inboxStateService
                          .populate(authV2Service.persistedUser!.userType);
                    });
                  },
                  onSliderTap: (channel, key) => InboxActions().slideTap(
                    channel,
                    key,
                    context,
                    channel.companyUsers.items.first.companyName,
                  ),
                  itemBuilder: (messageChannel) {
                    final company = messageChannel.companyUsers.items.first;
                    return ConversationModel(
                      id: messageChannel.id,
                      profile: company.companyLogo ?? "",
                      superUser: false,
                      online: false,
                      seen: messageChannel.isLastMessageSeen(state.userId),
                      favorite: messageChannel.isFavorite(state.userId),
                      title: company.companyName,
                      message: messageChannel.latestMessage?.inboxMessage ?? "",
                      timestamp: DateFormat.jm().format(
                        messageChannel.updatedAt.toString().fromTimeStamp(),
                      ),
                      state: messageChannel
                              .isLastMessageSeenByOtherUser(state.userId)
                          ? ConversationState.read
                          : ConversationState.delivered,
                      actionItems: [
                        SlidableActionItem(
                          icon: "message-x-circle",
                          title: currentLocalizations.unmatch,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0)),
                          background: ColorTheme.destructive500,
                          foreground: ColorTheme.shade00,
                        ),
                        SlidableActionItem(
                          icon: "dots-vertical",
                          title: currentLocalizations.more,
                          background: ColorTheme.primary500,
                          foreground: ColorTheme.shade00,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
