import 'package:upskill_consultancy/src/imports/core_imports.dart';
import 'package:upskill_consultancy/src/imports/packages_imports.dart';
import 'package:upskill_consultancy/src/features/services/data/models/service_model.dart';
import 'package:upskill_consultancy/src/features/services/data/repositories/services_repository_impl.dart';
import 'package:upskill_consultancy/src/features/services/domain/repositories/services_repository.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final ServicesRepository _repository = ServicesRepositoryImpl();

  List<ServiceModel> _services = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final res = await _repository.getServices();
    res.fold(
      (_) => _services = [],
      (list) => _services = list,
    );

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  IconData _getIconForName(String iconName) {
    switch (iconName) {
      case 'briefcase':
        return IconsaxPlusBold.briefcase;
      case 'teacher':
        return IconsaxPlusBold.teacher;
      case 'profile_2user':
        return IconsaxPlusBold.profile_2user;
      case 'code':
      default:
        return IconsaxPlusBold.code_circle;
    }
  }

  Color _getColorForIndex(int index, ColorScheme colorScheme) {
    const colors = [
      Color(0xFF019BFE),
      Color(0xFF0072BD),
      Color(0xFF10B981),
      Color(0xFFF59E0B),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppTopBar(
        title: 'services.title'.tr(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          color: colorScheme.primary,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            children: [
              // Header Banner
              Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: AppBorders.lg,
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UpSkill Consultancy Services',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      'services.subtitle'.tr(),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.xl),

              Text(
                'services.our_services'.tr(),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSpacing.md),

              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                ..._services.asMap().entries.map((entry) {
                  final index = entry.key;
                  final service = entry.value;
                  final serviceColor = _getColorForIndex(index, colorScheme);
                  final iconData = _getIconForName(service.iconName);

                  return Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.md),
                    child: Container(
                      padding: EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: AppBorders.card,
                        border: Border.all(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                        ),
                        boxShadow: AppShadows.subtle,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: serviceColor.withValues(alpha: 0.12),
                                  borderRadius: AppBorders.sm,
                                ),
                                child: Icon(
                                  iconData,
                                  color: serviceColor,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service.title,
                                      style: textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    SizedBox(height: AppSpacing.xxs),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: serviceColor.withValues(alpha: 0.1),
                                        borderRadius: AppBorders.xs,
                                      ),
                                      child: Text(
                                        service.badge,
                                        style: textTheme.labelSmall?.copyWith(
                                          color: serviceColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            service.subtitle,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),
                          if (service.features.isNotEmpty) ...[
                            SizedBox(height: AppSpacing.sm),
                            ...service.features.map(
                              (f) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Icon(
                                      IconsaxPlusBold.tick_circle,
                                      size: 14,
                                      color: serviceColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        f,
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),

              SizedBox(height: AppSpacing.md),

              // CTA Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(IconsaxPlusBold.calendar_1, size: 18),
                label: Text('services.consultation'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppBorders.button,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
