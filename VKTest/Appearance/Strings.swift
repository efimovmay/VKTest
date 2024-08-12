//
//  Strings.swift
//
//  Created by Aleksey Efimov
//

import Foundation

enum L10n {
	
	enum Common {
		static let ok = "Ок"
		static let error = "Ошибка"
		static let done = "Готово"
		static let cancel = "Отмена"
	}
	
	enum NetworkError {
		static let invalidURL = "Ошибка URL."
		static let networkError = "Сетевая ошибка."
		static let invalidResponse = "Ответ сервера имеет неожиданный формат."
		static let invalidStatusCode = "Cтатус код не входит в 200..<300."
		static let noData = "Данные отсутствуют."
		static let failedToDecodeResponse = "Ошибка декодирования"
	}
	
	enum AuthError {
		static let webLoadFail = "Не удалось загрузить станицу авторизации"
	}
	
	enum LoginScreen {
		static let title = "Mobile Up\nGallery"
		static let textButton = "Вход через VK"
	}
	
	enum GalleryScreen {
		static let title = "MobileUp Gallery"
		static let logout = "Выход"
		static let segmentFoto = "Фото"
		static let segmentVideo = "Видео"
	}
}
