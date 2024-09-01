/* Package Imports */
import 'package:union/features/group/domain/usecases/group_add_member.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:union/core/utils/injections.dart';
import 'package:flutter/material.dart';

class QrViewer extends StatefulWidget {
  const QrViewer({super.key});

  @override
  State<QrViewer> createState() => _QrViewerState();
}

class _QrViewerState extends State<QrViewer> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final messageFeedback = TextEditingController();

  Future<void> _fetchGroups() async {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId == null) return;

    final groupBloc = getIt<GroupBloc>();

    if (groupBloc.state is! GroupSuccessGetGroupsState) {
      groupBloc.add(GroupsGetEvent(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('QR Scanner')),
      body: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? _buildText(messageFeedback.text)
                  : _buildText('Aponte a câmera para o QR Code'),
            ),
          )
        ],
      ),
    );
  }

  Text _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 450.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          final data = result!.code;
          if (data != null) {
            final parts = data.split('|');
            if (parts.length == 2) {
              final groupId = parts[0];
              final ownerId = parts[1];
              controller.pauseCamera();
              _addMemberToGroup(groupId, ownerId);
            } else {
              setState(() {
                messageFeedback.text = 'QR Code inválido.';
              });
            }
          } else {
            setState(() {
              messageFeedback.text = 'Código escaneado inválido.';
            });
          }
        }
      });
    });
  }

  void _addMemberToGroup(String groupId, String ownerId) {
    final String? userId = getIt.get<UserCubit>().user?.id;

    getIt<GroupBloc>().add(GroupAddMemberEvent(
      params: GroupAddMemberParams(
        groupId: groupId,
        userId: userId ?? '',
      ),
    ));

    Navigator.of(context).pop();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissão da câmera negada')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    _fetchGroups();
    super.dispose();
  }
}
