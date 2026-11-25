import AVFoundation
import Flutter
import Speech
import UIKit

/// Append synchronously: no borrowed PCM buffers escape the audio tap.
private final class SpeechAudioRouter {
  private let lock = NSLock()
  private var request: SFSpeechAudioBufferRecognitionRequest?
  private var buffering = false
  private var buffers: [AVAudioPCMBuffer] = []
  private var duration: Double = 0
  private var bytes = 0
  private var overflow = false

  var hasBufferedAudio: Bool {
    lock.lock(); defer { lock.unlock() }
    return !buffers.isEmpty
  }

  var overflowed: Bool {
    lock.lock(); defer { lock.unlock() }
    return overflow
  }

  func replace(with next: SFSpeechAudioBufferRecognitionRequest?) {
    lock.lock()
    // Bounded PCM replay precedes live audio under the same lock.
    if let next = next {
      for buffer in buffers { next.append(buffer) }
    }
    request = next
    buffers.removeAll()
    duration = 0; bytes = 0; overflow = false; buffering = false
    lock.unlock()
  }

  func beginBuffering() {
    lock.lock()
    request = nil
    buffering = true
    lock.unlock()
  }

  func append(_ buffer: AVAudioPCMBuffer) {
    lock.lock()
    defer { lock.unlock() }
    if let request = request { request.append(buffer); return }
    guard buffering, !overflow else { return }
    guard buffer.frameLength > 0 else { return }
    // Core Audio's collection wrapper is mutable; this borrowed source is read only.
    let source = UnsafeMutableAudioBufferListPointer(UnsafeMutablePointer(mutating: buffer.audioBufferList))
    let length = source.reduce(0) { $0 + Int($1.mDataByteSize) }
    let seconds = Double(buffer.frameLength) / buffer.format.sampleRate
    guard duration + seconds <= 5, bytes + length <= 8 * 1024 * 1024,
          let copy = AVAudioPCMBuffer(pcmFormat: buffer.format, frameCapacity: buffer.frameLength) else {
      overflow = true; return
    }
    copy.frameLength = buffer.frameLength
    let destination = UnsafeMutableAudioBufferListPointer(copy.mutableAudioBufferList)
    guard destination.count == source.count else { overflow = true; return }
    for index in source.indices {
      guard destination[index].mDataByteSize >= source[index].mDataByteSize,
            let from = source[index].mData, let to = destination[index].mData else {
        overflow = true; return
      }
      to.copyMemory(from: from, byteCount: Int(source[index].mDataByteSize))
    }
    buffers.append(copy)
    duration += seconds
    bytes += length
  }
}

/// Main-queue state and ordered final results over one continuously running audio engine.
/// There is no server recognizer or automatic retry after a service error.
final class OnDeviceSpeechBridge: NSObject {
  private enum Phase { case ready, initializing, awaitingForeground, listening, finalizing, awaitingTask }
  private enum CaptureIntent { case continuous, stop }
  private final class Segment {
    let recognizer: SFSpeechRecognizer
    let request = SFSpeechAudioBufferRecognitionRequest()
    let started = Date()
    var task: SFSpeechRecognitionTask?
    var partial = ""
    var committed = false
    var deadline: DispatchWorkItem?
    var rollover: DispatchWorkItem?

    init(_ recognizer: SFSpeechRecognizer) { self.recognizer = recognizer }
    func release() {
      deadline?.cancel(); deadline = nil
      rollover?.cancel(); rollover = nil
      task?.cancel(); task = nil
    }
  }

  private let channel: FlutterMethodChannel
  private let router = SpeechAudioRouter()
  private var phase: Phase = .ready
  private var owner: Int64 = 0
  private var generation: UInt64 = 0
  private var engine: AVAudioEngine?
  private var ownsAudioSession = false
  private var locale = ""
  private var segment: Segment?
  private var captureIntent: CaptureIntent = .continuous
  private var completionTimer: DispatchWorkItem?
  private var initialization: FlutterResult?
  private var pendingForeground: (owner: Int64, generation: UInt64)?
  private var initializationTimer: DispatchWorkItem?
  private var stopping: FlutterResult?
  private var observers: [NSObjectProtocol] = []

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(name: "nshoptor/speech", binaryMessenger: messenger)
    super.init()
    channel.setMethodCallHandler { [weak self] call, result in
      DispatchQueue.main.async {
        guard let self = self else { result(false); return }
        self.handle(call, result: result)
      }
    }
    observers.append(NotificationCenter.default.addObserver(
      forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main
    ) { [weak self] _ in self?.resumeInitialization() })
    for name in [UIApplication.didEnterBackgroundNotification, AVAudioSession.interruptionNotification,
                 AVAudioSession.mediaServicesWereResetNotification] {
      observers.append(NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) {
        [weak self] notification in
        if notification.name == AVAudioSession.interruptionNotification,
           let type = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,
           type != AVAudioSession.InterruptionType.began.rawValue { return }
        self?.cancelSession()
      })
    }
  }

  func dispose() {
    cancelSession()
    channel.setMethodCallHandler(nil)
    observers.forEach { NotificationCenter.default.removeObserver($0) }
    observers.removeAll()
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let number = args["sessionId"] as? NSNumber, number.int64Value > 0 else {
      result(FlutterError(code: "invalid_session", message: "Invalid session", details: nil)); return
    }
    let session = number.int64Value
    if call.method == "initialize" { initialize(session, result: result); return }
    guard owner == session else {
      if call.method == "stop" || call.method == "cancel" { result(nil) }
      else { result(FlutterError(code: "inactive_session", message: "Inactive session", details: nil)) }
      return
    }
    switch call.method {
    case "locales":
      guard authorized, phase != .initializing, phase != .awaitingForeground else {
        result([String]()); return
      }
      // Capabilities, not a promise that Apple has installed every language asset.
      result(SFSpeechRecognizer.supportedLocales().filter {
        guard let candidate = SFSpeechRecognizer(locale: $0) else { return false }
        return candidate.supportsOnDeviceRecognition && candidate.isAvailable
      }.map { $0.identifier.replacingOccurrences(of: "_", with: "-") }.sorted())
    case "downloadModel":
      // SFSpeechRecognizer exposes no public offline model download control.
      result(false)
    case "start": start(args["locale"] as? String, result: result)
    case "stop": stop(result: result)
    case "cancel": cancelSession(); result(nil)
    default: result(FlutterMethodNotImplemented)
    }
  }

  private var foreground: Bool { UIApplication.shared.applicationState == .active }
  private var authorized: Bool {
    SFSpeechRecognizer.authorizationStatus() == .authorized &&
      AVAudioSession.sharedInstance().recordPermission == .granted
  }

  private func initialize(_ session: Int64, result: @escaping FlutterResult) {
    cancelSession()
    owner = session
    guard foreground,
          let speechPurpose = Bundle.main.object(forInfoDictionaryKey: "NSSpeechRecognitionUsageDescription") as? String,
          !speechPurpose.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
          let microphonePurpose = Bundle.main.object(forInfoDictionaryKey: "NSMicrophoneUsageDescription") as? String,
          !microphonePurpose.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
      result(false); return
    }
    phase = .initializing
    initialization = result
    let version = generation
    SFSpeechRecognizer.requestAuthorization { [weak self] permission in
      DispatchQueue.main.async {
        guard let self = self, self.owner == session, self.generation == version,
              self.phase == .initializing else { return }
        guard permission == .authorized else { self.finishInitialization(false); return }
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
          DispatchQueue.main.async {
            guard let self = self, self.owner == session, self.generation == version,
                  self.phase == .initializing else { return }
            guard granted else { self.finishInitialization(false); return }
            // Permission completion can precede the system dialog's active transition.
            self.phase = .awaitingForeground
            self.pendingForeground = (session, version)
            let timeout = DispatchWorkItem { [weak self] in
              guard let self = self, self.owner == session, self.generation == version,
                    self.phase == .awaitingForeground else { return }
              self.finishInitialization(false)
            }
            self.initializationTimer = timeout
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: timeout)
            self.resumeInitialization()
          }
        }
      }
    }
  }

  private func resumeInitialization() {
    guard let pending = pendingForeground, pending.owner == owner,
          pending.generation == generation, phase == .awaitingForeground, foreground else { return }
    finishInitialization(authorized)
  }

  private func finishInitialization(_ available: Bool) {
    initializationTimer?.cancel(); initializationTimer = nil
    pendingForeground = nil
    let callback = initialization
    initialization = nil
    phase = .ready
    callback?(available)
  }

  private func start(_ language: String?, result: @escaping FlutterResult) {
    guard phase == .ready, foreground, authorized else {
      result(FlutterError(code: "serviceUnavailablePermission", message: "Speech is unavailable", details: nil)); return
    }
    guard let language = language, !language.isEmpty, language.count <= 100 else {
      result(FlutterError(code: "unsupportedLanguage", message: "On-device language unavailable", details: nil)); return
    }
    locale = language
    captureIntent = .continuous
    do {
      let audio = AVAudioSession.sharedInstance()
      try audio.setCategory(.record, mode: .measurement, options: [])
      try audio.setActive(true)
      ownsAudioSession = true
      let audioEngine = AVAudioEngine()
      let input = audioEngine.inputNode
      let format = input.outputFormat(forBus: 0)
      guard format.sampleRate.isFinite, format.sampleRate > 0, format.channelCount > 0 else {
        throw NSError(domain: "NShoptorSpeech", code: 1)
      }
      generation &+= 1
      let first = try makeSegment()
      router.replace(with: first.request)
      let audioRouter = router
      input.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
        audioRouter.append(buffer)
      }
      engine = audioEngine
      audioEngine.prepare()
      try audioEngine.start()
      emit("status", ["listening": true])
      result(nil)
    } catch {
      finishSession()
      result(FlutterError(code: "serviceUnavailable", message: "On-device speech unavailable", details: nil))
    }
  }

  private func makeSegment() throws -> Segment {
    guard foreground, authorized,
          let candidate = SFSpeechRecognizer(locale: Locale(identifier: locale.replacingOccurrences(of: "-", with: "_"))),
          candidate.supportsOnDeviceRecognition, candidate.isAvailable else {
      throw NSError(domain: "NShoptorSpeech", code: 2)
    }
    let current = Segment(candidate)
    current.request.requiresOnDeviceRecognition = true
    current.request.shouldReportPartialResults = true
    current.request.taskHint = .dictation
    segment = current
    phase = .listening
    let version = generation, session = owner
    candidate.queue = OperationQueue.main
    current.task = candidate.recognitionTask(with: current.request) { [weak self, weak current] response, error in
      DispatchQueue.main.async {
        guard let self = self, let current = current, self.owner == session,
              self.generation == version, self.segment === current, !current.committed,
              self.phase == .listening || self.phase == .finalizing else { return }
        if let response = response {
          let text = response.bestTranscription.formattedString
          if !text.isEmpty { current.partial = text }
          if response.isFinal {
            if self.phase == .listening && self.captureIntent == .continuous {
              // Do not repeatedly restart on a recognizer's immediate empty final.
              guard !current.partial.isEmpty || Date().timeIntervalSince(current.started) >= 1 else {
                self.finishSession(); return
              }
              self.router.beginBuffering()
              current.request.endAudio()
            }
            self.completeSegment(current, cancelTask: false)
            return
          }
          if !text.isEmpty { self.emit("result", ["text": text, "final": false]) }
        }
        if error != nil {
          if self.phase == .finalizing {
            self.completeSegment(current, cancelTask: true)
          } else {
            self.failSession()
          }
        }
      }
    }
    if captureIntent == .continuous {
      let rollover = DispatchWorkItem { [weak self, weak current] in
        guard let self = self, let current = current, self.generation == version,
              self.owner == session, self.phase == .listening, self.segment === current else { return }
        self.beginFinalization(current)
      }
      current.rollover = rollover
      DispatchQueue.main.asyncAfter(deadline: .now() + 55, execute: rollover)
    }
    return current
  }

  /// The engine remains live; copy new PCM while the prior ASR task finishes.
  private func beginFinalization(_ current: Segment) {
    router.beginBuffering()
    phase = .finalizing
    current.rollover?.cancel(); current.rollover = nil
    current.request.endAudio()
    boundFinalization(current)
  }

  private func boundFinalization(_ current: Segment) {
    current.deadline?.cancel()
    let version = generation, session = owner
    let timeout = DispatchWorkItem { [weak self, weak current] in
      guard let self = self, let current = current, self.generation == version,
            self.owner == session, self.segment === current, !current.committed else { return }
      self.completeSegment(current, cancelTask: true)
    }
    current.deadline = timeout
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: timeout)
  }

  private func commit(_ current: Segment) {
    guard !current.committed else { return }
    current.committed = true
    let text = current.partial.trimmingCharacters(in: .whitespacesAndNewlines)
    if !text.isEmpty { emit("result", ["text": text, "final": true]) }
  }

  private func completeSegment(_ current: Segment, cancelTask: Bool) {
    commit(current)
    current.deadline?.cancel(); current.deadline = nil
    current.rollover?.cancel(); current.rollover = nil
    phase = .awaitingTask
    if router.overflowed { failSession(); return }
    if captureIntent == .stop && !router.hasBufferedAudio { finishSession(); return }
    if cancelTask { current.task?.cancel() }
    // Apple's recognizer rejects overlapping tasks (error 1100). Start a successor
    // only after the old task has completed, while audio continues into copied PCM.
    awaitTaskCompletion(current, deadline: Date().addingTimeInterval(1))
  }

  private func awaitTaskCompletion(_ current: Segment, deadline: Date) {
    guard segment === current, phase == .awaitingTask else { return }
    if router.overflowed { failSession(); return }
    if current.task == nil || current.task?.state == .completed {
      current.release()
      segment = nil
      guard captureIntent == .continuous || router.hasBufferedAudio else { finishSession(); return }
      do {
        let next = try makeSegment()
        router.replace(with: next.request) // Ordered buffered replay, then live audio.
        if captureIntent == .stop {
          phase = .finalizing
          next.request.endAudio()
          boundFinalization(next)
        }
      } catch { failSession() }
      return
    }
    guard Date() < deadline else { failSession(); return }
    let version = generation, session = owner
    let poll = DispatchWorkItem { [weak self, weak current] in
      guard let self = self, let current = current, self.generation == version, self.owner == session else { return }
      self.awaitTaskCompletion(current, deadline: deadline)
    }
    completionTimer = poll
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: poll)
  }

  private func stop(result: @escaping FlutterResult) {
    if phase == .initializing || phase == .awaitingForeground { cancelSession(); result(nil); return }
    if phase == .ready { result(nil); return }
    stopping?(nil)
    stopping = result
    captureIntent = .stop
    engine?.stop() // Preserve any already buffered audio for a final successor task.
    if phase == .listening, let current = segment {
      beginFinalization(current)
    }
    // While finalizing/awaitingTask, the existing bounded pipeline drains copied
    // audio too. Worst-case stop wait is 3s final + 1s completion + 3s buffered final.
  }

  private func failSession() {
    if let current = segment { commit(current) }
    emit("error", ["code": "serviceUnavailable"])
    finishSession()
  }

  private func finishSession() {
    generation &+= 1
    completionTimer?.cancel(); completionTimer = nil
    router.replace(with: nil)
    engine?.stop()
    engine?.inputNode.removeTap(onBus: 0)
    engine = nil
    segment?.release()
    segment = nil
    if ownsAudioSession {
      ownsAudioSession = false
      try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    phase = .ready
    emit("status", ["listening": false])
    let callback = stopping
    stopping = nil
    callback?(nil)
  }

  private func cancelSession() {
    finishSession()
    owner = 0
    finishInitialization(false)
  }

  private func emit(_ type: String, _ fields: [String: Any]) {
    guard owner > 0 else { return }
    var event = fields
    event["type"] = type
    event["sessionId"] = owner
    channel.invokeMethod("event", arguments: event)
  }
}
