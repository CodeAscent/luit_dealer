import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';
import 'package:luit_dealer/features/dashoard/repo/dashboard_repo.dart';

class DashboardViewmodel {
  final DashboardRepo dashboardRepo;

  DashboardViewmodel(this.dashboardRepo);

  Future getDashboard({int? week, int? month, int? year, String? date}) async {
    try {
      final res = await dashboardRepo.getDashboard(week: week, month: month, year: year, date: date);
      if (res != null) {
        return res['data'];
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }
}
