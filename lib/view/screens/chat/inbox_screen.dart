import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/data/model/response/chat_model.dart';
import 'package:medosedo_vendor/localization/language_constrants.dart';
import 'package:medosedo_vendor/provider/chat_provider.dart';
import 'package:medosedo_vendor/utill/color_resources.dart';
import 'package:medosedo_vendor/utill/dimensions.dart';
import 'package:medosedo_vendor/view/base/custom_app_bar.dart';
import 'package:medosedo_vendor/view/base/custom_loader.dart';
import 'package:medosedo_vendor/view/base/no_data_screen.dart';
import 'package:medosedo_vendor/view/base/paginated_list_view.dart';
import 'package:medosedo_vendor/view/screens/chat/widget/chat_card_widget.dart';
import 'package:medosedo_vendor/view/screens/chat/widget/chat_header.dart';

class InboxScreen extends StatefulWidget {
  final bool isBackButtonExist;
  InboxScreen({this.isBackButtonExist = true,});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  ScrollController _scrollController = ScrollController();

@override
  void initState() {

  Provider.of<ChatProvider>(context, listen: false).getChatList(context, 1);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: CustomAppBar(title: getTranslated('inbox', context)),
      body: Consumer<ChatProvider>(builder: (context, chatProvider, child) {
        List<Chat> _chatList=[];
         _chatList = chatProvider.chatModel!.chat??[];
        return Column(children: [

          Container(
              padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child:  const ChatHeader()),

              chatProvider.chatModel!=null?
          Expanded(
            child:  RefreshIndicator(
              onRefresh: () async {
                chatProvider.getChatList(context,1);
              },
              child: Scrollbar(child: SingleChildScrollView(controller: _scrollController,
                  child: Center(child: SizedBox(width: 1170,
                      child:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child:
                        chatProvider.chatModel!.chat!.isNotEmpty?

        PaginatedListView(
                          reverse: false,
                          scrollController: _scrollController,
                          onPaginate: (int? offset) => chatProvider.getChatList(context,offset!, reload: false),
                          totalSize: chatProvider.chatModel!.totalSize,
                          offset: int.parse(chatProvider.chatModel!.offset!),
                          enabledPagination: chatProvider.chatModel == null,
                          itemView: ListView.builder(
                            itemCount: chatProvider.chatModel!.chat!.length,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return  ChatCardWidget(chat: chatProvider.chatModel!.chat![index]);
                            },
                          ),
                        ):
                        NoDataScreen(),
                      ))))),
            ),
          ) :
         CustomLoader(height: MediaQuery.of(context).size.height-500)
            ,

        ]);
      },
      ),
    );
  }
}



