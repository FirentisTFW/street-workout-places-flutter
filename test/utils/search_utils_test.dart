import 'package:app/domain/core/utils/search_utils.dart';
import 'package:app/domain/models/workout_spot_model.dart';
import 'package:app/infrastructure/networking/models/address.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchUtilsTest -', () {
    group('checkIfSpotMatchesQuery -', () {
      group('single word query -', () {
        group('spot name -', () {
          const WorkoutSpotModel spot = WorkoutSpotModel(
            id: 1,
            name: 'Poznań super park',
          );
          test('with diacritics', () {
            final bool resultMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
              spot: spot,
              query: 'Poznań',
            );
            final bool resultNotMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
              spot: spot,
              query: 'Warszawa',
            );
            expect(resultMatchingQuery, true);
            expect(resultNotMatchingQuery, false);
          });
          test('without diacritics', () {
            final bool result = SearchUtils.checkIfSpotMatchesQuery(
              spot: spot,
              query: 'Poznan',
            );
            expect(result, true);
          });
        });
        group('spot address -', () {
          const String query = 'Poznań';
          test('city', () {
            const WorkoutSpotModel spotMatchingQuery = WorkoutSpotModel(
              id: 1,
              address: Address(
                city: 'Poznań',
              ),
            );
            const WorkoutSpotModel spotNotMatchingQuery = WorkoutSpotModel(
              id: 2,
              address: Address(
                city: 'Warszawa',
              ),
            );
            final bool resultMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
              spot: spotMatchingQuery,
              query: query,
            );
            final bool resultNotMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
              spot: spotNotMatchingQuery,
              query: query,
            );
            expect(resultMatchingQuery, true);
            expect(resultNotMatchingQuery, false);
          });

          test('street', () {
            const WorkoutSpotModel spotMatchingQuery = WorkoutSpotModel(
              id: 1,
              address: Address(
                city: 'Warszawa',
                street: 'Poznańska',
              ),
            );
            const WorkoutSpotModel spotNotMatchingQuery = WorkoutSpotModel(
              id: 2,
              address: Address(
                city: 'Warszawa',
                street: 'Krakowska',
              ),
            );
            final bool resultMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
              spot: spotMatchingQuery,
              query: query,
            );
            final bool resultNotMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
              spot: spotNotMatchingQuery,
              query: query,
            );
            expect(resultMatchingQuery, true);
            expect(resultNotMatchingQuery, false);
          });
        });
      });
      test('multiple word query', () {
        const String query = 'krakow poznanska';
        const WorkoutSpotModel spotMatchingQuery = WorkoutSpotModel(
          id: 1,
          address: Address(
            city: 'Kraków',
            street: 'Poznańska',
          ),
        );
        const WorkoutSpotModel spotNotMatchingQuery = WorkoutSpotModel(
          id: 2,
          address: Address(
            city: 'Kraków',
            street: 'Warszawska',
          ),
        );
        final bool resultMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
          spot: spotMatchingQuery,
          query: query,
        );
        final bool resultNotMatchingQuery = SearchUtils.checkIfSpotMatchesQuery(
          spot: spotNotMatchingQuery,
          query: query,
        );
        expect(resultMatchingQuery, true);
        expect(resultNotMatchingQuery, false);
      });
    });
  });
}
