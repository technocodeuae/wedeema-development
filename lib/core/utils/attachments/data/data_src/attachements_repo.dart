// import 'dart:io';
//
// import 'package:uploadcare_client/uploadcare_client.dart' as uploadcare;
//
// class AttachmentsRepo {
//   Future<Result<AttachmentModel>> uploadFile(
//       {required File file,
//       void Function(uploadcare.ProgressEntity)? onProgress,
//       uploadcare.CancelToken? cancelToken}) async {
//     final result = await ApiProvider.uploadUploadCare(file,
//         onProgress: onProgress, cancelToken: cancelToken);
//     if (result.hasDataOnly) {
//       return Result(
//           data: AttachmentModel(
//               url: result.data, type: PostAttachmentTypeEnum.image));
//     } else {
//       return Result(error: result.error);
//     }
//   }
//
//   Future<Result<AttachmentEntity>> uploadFileReturnEntity(
//       {required File file,
//       void Function(uploadcare.ProgressEntity)? onProgress,
//       uploadcare.CancelToken? cancelToken}) async {
//     final result = await ApiProvider.uploadUploadCare(file,
//         onProgress: onProgress, cancelToken: cancelToken);
//     if (result.hasDataOnly) {
//       return Result(
//         data: AttachmentEntity(
//           url: result.data,
//           type: PostAttachmentTypeEnum.image,
//         ),
//       );
//     } else {
//       return Result(error: result.error);
//     }
//   }
// }
