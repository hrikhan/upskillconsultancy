import 'package:upskill_consultancy/src/imports/core_imports.dart';
import 'package:upskill_consultancy/src/imports/packages_imports.dart';
import 'package:upskill_consultancy/src/features/auth/presentation/providers/session_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final session = context.watch<SessionBloc>().state;
    final user = session.user;

    final isBangla = context.locale.languageCode == 'bn';

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppTopBar(
        title: 'dashboard.title'.tr(),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          children: [
            // Profile Card
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppBorders.card,
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                ),
                boxShadow: AppShadows.subtle,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
                    child: Text(
                      ((user?.name?.isNotEmpty ?? false)
                              ? user!.name![0]
                              : ((user?.email.isNotEmpty ?? false) ? user!.email[0] : 'U'))
                          .toUpperCase(),
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'UpSkill Student',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xxs),
                        Text(
                          user?.email ?? 'student@upskill.com',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.12),
                            borderRadius: AppBorders.xs,
                          ),
                          child: const Text(
                            'Active Student Member',
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.xl),

            // Settings Section
            Text(
              'dashboard.settings'.tr(),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Language Switch Tile
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppBorders.card,
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: AppBorders.sm,
                  ),
                  child: Icon(
                    IconsaxPlusLinear.global,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                ),
                title: Text(
                  'dashboard.language'.tr(),
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  isBangla ? 'বাংলা (Bangla)' : 'English',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    if (isBangla) {
                      context.setLocale(const Locale('en'));
                    } else {
                      context.setLocale(const Locale('bn'));
                    }
                  },
                  child: Text(
                    isBangla ? 'Switch to English' : 'বাংলায় দেখুন',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm),

            // Help & Support
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppBorders.card,
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: AppBorders.sm,
                  ),
                  child: const Icon(
                    IconsaxPlusLinear.info_circle,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Help & Support',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Contact UpSkill support & FAQs',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: const Icon(IconsaxPlusLinear.arrow_right_3, size: 16),
                onTap: () {},
              ),
            ),
            SizedBox(height: AppSpacing.sm),

            // Logout Tile
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppBorders.card,
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: AppBorders.sm,
                  ),
                  child: const Icon(
                    IconsaxPlusLinear.logout,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                title: Text(
                  'dashboard.logout'.tr(),
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                subtitle: Text(
                  'Sign out of your UpSkill account',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                onTap: () {
                  context.read<SessionBloc>().add(const SessionLogoutRequested());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
