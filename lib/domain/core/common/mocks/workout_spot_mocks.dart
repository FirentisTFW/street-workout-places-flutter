import 'package:app/domain/core/common/mocks/review_mocks.dart';
import 'package:app/infrastructure/networking/models/address.dart';
import 'package:app/infrastructure/networking/models/equipment.dart';
import 'package:app/infrastructure/networking/models/map_position.dart';
import 'package:app/infrastructure/networking/models/surface.dart';
import 'package:app/infrastructure/networking/models/workout_spot.dart';
import 'package:app/infrastructure/networking/models/workout_spot_size.dart';

abstract final class WorkoutSpotMocks {
  const WorkoutSpotMocks._();

  static List<WorkoutSpot> spots = [
    WorkoutSpot(
      address: const Address(
        city: 'Poznań',
        street: 'Park Drwęskich',
      ),
      coordinates: const MapPosition(
        latitude: 52.39963,
        longitude: 16.92525,
      ),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
      equipment: const [
        Equipment.highBar,
        Equipment.horizontalLadder,
        Equipment.lowBar,
        Equipment.parallelBars,
        Equipment.pole,
        Equipment.verticalLadder,
      ],
      id: 0,
      images: const [
        'https://lh5.googleusercontent.com/p/AF1QipP5ghK2uD5Bxj1HeUcfIn-pSVp9eRP8NVA3LLPZ=w408-h306-k-no',
        'https://lh3.googleusercontent.com/p/AF1QipNfsvvEW_hiDcOhIFfTUpGqCqhg-XhzocKLcXIc=w600-k',
        'https://lh3.googleusercontent.com/p/AF1QipMRTY1h-st6dH6nABWrEvCrxfiGRjYXRGIF5LLL=w600-k',
        'https://lh3.googleusercontent.com/p/AF1QipPDu5aHVBqcgtpoNfbuYLQXwcq_bDN8qtacbc0-=w600-k',
      ],
      name: 'Park Drwęskich',
      reviews: ReviewMocks.reviews,
      size: WorkoutSpotSize.medium,
      surface: Surface.tartan,
    ),
    WorkoutSpot(
      address: const Address(
        city: 'Poznań',
        street: 'Park Jana Pawła II',
      ),
      coordinates: const MapPosition(
        latitude: 52.38908,
        longitude: 16.92539,
      ),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
      equipment: const [
        Equipment.highBar,
        Equipment.horizontalLadder,
        Equipment.lowBar,
        Equipment.parallelBars,
        Equipment.pole,
        Equipment.rope,
        Equipment.parkourWalls,
        Equipment.verticalLadder,
      ],
      id: 1,
      images: const [
        'https://lh3.googleusercontent.com/p/AF1QipPDu5aHVBqcgtpoNfbuYLQXwcq_bDN8qtacbc0-=w600-k',
        'https://lh5.googleusercontent.com/p/AF1QipP5ghK2uD5Bxj1HeUcfIn-pSVp9eRP8NVA3LLPZ=w408-h306-k-no',
      ],
      name: 'Park Jana Pawła II',
      reviews: ReviewMocks.reviews,
      size: WorkoutSpotSize.medium,
      surface: Surface.tartan,
    ),
    WorkoutSpot(
      address: const Address(
        city: 'Poznań',
        street: 'Osiedle Zwycięstwa',
      ),
      coordinates: const MapPosition(
        latitude: 52.44089,
        longitude: 16.92665,
      ),
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
      equipment: const [
        Equipment.highBar,
        Equipment.horizontalLadder,
        Equipment.lowBar,
        Equipment.parallelBars,
        Equipment.pole,
        Equipment.rope,
        Equipment.verticalLadder,
      ],
      id: 2,
      images: const [
        'https://lh3.googleusercontent.com/p/AF1QipMRTY1h-st6dH6nABWrEvCrxfiGRjYXRGIF5LLL=w600-k',
        'https://lh3.googleusercontent.com/p/AF1QipPDu5aHVBqcgtpoNfbuYLQXwcq_bDN8qtacbc0-=w600-k',
        'https://lh5.googleusercontent.com/p/AF1QipP5ghK2uD5Bxj1HeUcfIn-pSVp9eRP8NVA3LLPZ=w408-h306-k-no',
      ],
      name: 'Osiedle Zwycięstwa',
      reviews: ReviewMocks.reviews,
      size: WorkoutSpotSize.big,
      surface: Surface.tartan,
    ),
  ];
}
