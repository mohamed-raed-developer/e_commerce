import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:logger/logger.dart';

import '../../routes/app_pages.dart';

class BaseClient {
  //dio instance
  static final Dio _dio = Dio()
    ..options = BaseOptions(
      receiveTimeout: 10000,
      sendTimeout: 10000,
      connectTimeout: 15000,
    );

  /// download file
  static download(
      {required String url,
      required String savePath,
      Function(String)? onError,
      Function(int value, int progress)? onReceiveProgress,
      required Function onSuccess}) async {
    try {
      await _dio.download(
        url,
        savePath,
        options: Options(receiveTimeout: 999999, sendTimeout: 999999),
        onReceiveProgress: onReceiveProgress,
      );
      onSuccess();
    } catch (error) {
      if (onError != null) {
        await onError(error.toString());
      } else {
        Get.snackbar('Error!', error.toString());
      }
    }
  }

  /// dio get request
  static get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Function(String)? onError,
    required Function(Response response) onSuccess,
    Function(int value, int progress)? onReceiveProgress,
    Function? onLoading,
  }) async {
    try {
      // 1) indicate loading state
      if (onLoading != null) onLoading();
      // 2) try to perform http request
      var response = await _dio.get(
        url,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      // 3) if everything went fine return response
      //Logger().e(response.data);
      await onSuccess(response);
    } on DioError catch (error) {
      // *) print error
      Logger().e(error.type);
      Logger().e(error.message);
      Logger().e(error.response);
      Logger().e(StackTrace.current);

      // if the error is on server (500)
      if (error.response != null && error.response!.statusCode == 500) {
        if (onError != null) {
          onError('Server Error!');
          return;
        }
        Get.snackbar('Warning!', 'Error on server side!');
        return;
      }

      // check if there was response and error message from api
      if (error.response != null) {
        try {
          // NOTE: this is only for the current api that iam working on it you can delete it if you want
          var rv = error.response!.data[
              'rv']; // rv return by api if(rv) is greater than 1 then there was error

          if (rv != null && rv > 1) {
            if (onError != null) {
              await onError(error.response!.data['Msg']);
              return;
            } else {
              Get.snackbar('Error!', error.message);
              return;
            }
          } else {
            if (rv != null) {
              if (rv == -2) {
                // special case (when user want to make session but he didn't subscribe (payed))
                Get.snackbar('Error!', error.response!.data['Msg']);
                // Get.toNamed(Routes.SUBSCRIBE);
                return;
              }
            }
          }
        } catch (error) {}

        try {
          dynamic msg = error.response!.data['Msg'];
          if (msg != null) {
            if (onError != null) {
              await onError(error.response!.data['Msg']);
              return;
            } else {
              Get.snackbar('Error!', error.response!.data['Msg']);
              return;
            }
          }
        } catch (error) {}
      } else {
        // there was no response & message from api.
        if (onError != null) {
          onError(error.message);
          return;
        }
        Get.snackbar('Error!', error.message);
        return;
      }
    } on SocketException catch (error) {
      // if there is no internet connection
      if (onError != null) {
        await onError('No Internet');
        return;
      } else {
        Get.snackbar('Error!', 'NO_INTERNET_CONNECTION');
        return;
      }
    } catch (error) {
      // any other types of error (if u parse json incorrectly or something like this
      if (onError != null) {
        await onError(error.toString());
        return;
      } else {
        Get.snackbar('Error!', error.toString());
        return;
      }
    }
  }

  /// dio get request
  static post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Function(String)? onError,
    Function(int sent, int total)? onSendProgress,
    dynamic data,
    required Function(Response response) onSuccess,
    Function? onLoading,
  }) async {
    try {
      if (data is FormData) {
        // make request time longer cuz file uploading take a while
        _dio.options = BaseOptions(
          receiveTimeout: 10000,
          sendTimeout: 10000,
          connectTimeout: 100 * 1000, // 100 second
        );
      } else {
        _dio.options = BaseOptions(
          receiveTimeout: 10000,
          sendTimeout: 10000,
          connectTimeout: 15 * 1000, // 15 second
        );
      }

      // 1) indicate loading state
      if (onLoading != null) onLoading();
      // 2) try to perform http request
      var response = await _dio.post(
        url,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      // 3) if everything went fine return response
      await onSuccess(response);
    } on DioError catch (error) {
      // *) print error
      Logger().e(error);
      Logger().e(error.message);
      Logger().e(error.response);
      Logger().e(StackTrace.current);

      // if the error is on server (500)
      if (error.response != null && error.response!.statusCode == 500) {
        if (onError != null) {
          onError('Server Error!');
          return;
        }
        Get.snackbar('Warning!', 'Error on server side!');
        return;
      }

      // check if there was response and error message from api
      if (error.response != null) {
        try {
          // NOTE: this is only for the current api that iam working on it you can delete it if you want
          dynamic rv = int.parse(error.response!.data['rv']
              .toString()); // rv return by api if(rv) is greater than 1 then there was error

          Logger().e('Rv => ${rv}');
          if (rv != null && rv > 1) {
            if (onError != null) {
              await onError(
                  error.response!.data['Msg'] ?? error.response!.data['msg']);
              return;
            } else {
              Get.snackbar('Error!',
                  error.response!.data['Msg'] ?? error.response!.data['msg']);
              return;
            }
          } else {
            if (rv != null) {
              if (rv == -2) {
                // special case (when user want to make session but he didn't subscribe (payed))
                Get.snackbar('Error!', error.response!.data['Msg']);
                // Get.toNamed(Routes.SUBSCRIBE);
                return;
              } else {
                Logger().e('haha');
                if (onError != null) {
                  onError(error.response!.data['Msg'] ??
                      error.response!.data['msg']);
                  return;
                }
                Get.snackbar('Error!',
                    error.response!.data['Msg'] ?? error.response!.data['msg']);
                return;
              }
            }
          }
        } catch (error) {}

        try {
          dynamic msg = error.response!.data['Msg'];
          if (msg != null) {
            if (onError != null) {
              await onError(error.response!.data['Msg']);
              return;
            } else {
              Get.snackbar('Error!', error.response!.data['Msg']);
              return;
            }
          }
        } catch (error) {}
      } else {
        // there was no response & message from api.
        Get.snackbar('Error!', error.message);
        return;
      }
    } on SocketException catch (error) {
      // if there is no internet connection
      if (onError != null) {
        onError('NO_INTERNET_CONNECTION');
        return;
      } else {
        Get.snackbar('Error!', 'NO_INTERNET_CONNECTION');
        return;
      }
    } catch (error) {
      if (onError != null) {
        await onError(error.toString());
        return;
      } else {
        Get.snackbar('Error!', error.toString());
        return;
      }
    }
  }
}
