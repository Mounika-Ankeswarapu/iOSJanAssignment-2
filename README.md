# iOSJanAssignment-2
 Objective:
Implement an interactive UI component where swiping an image carousel dynamically updates the corresponding list content displayed in a table view. This implementation is designed with an emphasis on user-friendly interaction and intuitive navigation.

Key Features and Implementation Details:
Table View for List Display:

The list content is rendered using a UITableView, providing a structured and scrollable display. Each table view cell corresponds to a specific set of images and related content.
Image Carousel with Collection View:

A UICollectionView is embedded within each table view cell to serve as an image carousel.
The carousel supports horizontal scrolling, allowing users to swipe through images seamlessly.
A UIPageControl is integrated to visually indicate the current page (or image) within the carousel.
Dynamic Content Update:

When the user swipes through the image carousel, the corresponding list content is dynamically updated in real-time.
This creates a synchronized relationship between the image carousel and the table view content, enhancing the overall user experience.
Search Functionality:

A UISearchBar is implemented to enable content filtering within the list.
Users can search through the list items, with results dynamically displayed in the table view.
User Experience Enhancements:

Smooth animations for carousel transitions and content updates.
Intuitive page control for visual feedback during carousel interactions.
Efficient handling of search results to ensure responsive and lag-free performance.
