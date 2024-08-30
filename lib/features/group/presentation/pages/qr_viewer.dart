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
                  ? Text(messageFeedback.text)
                  : const Text('Aponte a câmera para o QR Code'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 350.0;
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
        setState(() {
          messageFeedback.text = 'Código escaneado: $result';
        });
        if (result != null) {
          final data = result!.code;
          if (data != null) {
            final parts = data.split('|');
            if (parts.length == 2) {
              final groupId = parts[0];
              final ownerId = parts[1];
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

    setState(() {
      messageFeedback.text = 'Adicionando membro ao grupo...';
    });

    getIt<GroupBloc>().add(GroupAddMemberEvent(
      params: GroupAddMemberParams(
        groupId: groupId,
        userId: userId ?? '',
      ),
    ));
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
    super.dispose();
  }
}
