import '../datasources/local_datasource.dart';
import '../models/metric.dart';

class MetricsRepository {
  final LocalDataSource dataSource;
  MetricsRepository(this.dataSource);

  Future<MetricsDataset> getDataset() => dataSource.loadPersistedOrDefault();
  Future<void> saveDataset(MetricsDataset dataset) => dataSource.saveMetrics(dataset);
}